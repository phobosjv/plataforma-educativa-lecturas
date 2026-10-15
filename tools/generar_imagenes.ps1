<#
.SYNOPSIS
  Genera las imágenes de una lectura con Nano Banana (Google Gemini) y las guarda en su carpeta.

.DESCRIPTION
  Lee los prompts de la sección 3 de la ficha <slug>.txt, los envía al modelo de imagen de
  Google (por defecto gemini-3.1-flash-image = "Nano Banana 2") y guarda el resultado en la
  carpeta de la lectura:
    - <slug>_mini_800x500.png   (recortada y ajustada a 800x500)
    - <slug>_cuerpo_1.png / <slug>_cuerpo_2.png   (ancho 1200 px, sin recorte)

  La clave de API se lee de la variable de entorno GEMINI_API_KEY o, en su defecto, del
  fichero .env (no versionado) situado en la raíz del repositorio, con la línea:
    GEMINI_API_KEY=tu_clave

  Códigos de salida:
    0  Todo correcto: imágenes generadas
    1  Falta la clave de API (no está configurada)
    2  Sin cuota/créditos libres: repetir más tarde (la cuota gratuita se recarga cada 24 h)
    3  El modelo no está disponible para esta clave
    4  No se encontraron prompts en la ficha, u otro error
    5  La clave de API no es válida (401 / API_KEY_INVALID)

.EXAMPLE
  .\tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga
  .\tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga -Imagen miniatura
  .\tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga -ExtractOnly
  .\tools\generar_imagenes.ps1 -ComprobarClave
#>

[CmdletBinding()]
param(
  # Carpeta de la lectura (<seccion>/<slug>) o ruta completa al fichero .txt
  [Parameter(Mandatory = $false)]
  [string]$Lectura,

  [ValidateSet('todas', 'miniatura', 'cuerpo1', 'cuerpo2')]
  [string]$Imagen = 'todas',

  # Nano Banana 2 (flash). Alternativas: gemini-3.1-flash-lite-image, gemini-3-pro-image
  [string]$Modelo = 'gemini-3.1-flash-image',

  [int]$AnchoMini = 800,
  [int]$AltoMini = 500,
  [int]$AnchoCuerpo = 1200,

  # Relación de aspecto pedida al modelo
  [string]$Relacion = '16:9',

  # Solo mostrar los prompts leídos de la ficha, sin llamar a la API
  [switch]$ExtractOnly,

  # Solo comprobar que la clave y el modelo responden (sin generar imagen)
  [switch]$ComprobarClave
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }

$BASE = 'https://generativelanguage.googleapis.com/v1beta'
$RAIZ = Split-Path -Parent $PSScriptRoot

# ---------------------------------------------------------------------------
# Utilidades
# ---------------------------------------------------------------------------

function Write-Info([string]$Mensaje) { Write-Host $Mensaje }
function Write-Aviso([string]$Mensaje) { Write-Host $Mensaje -ForegroundColor Yellow }
function Write-Ok([string]$Mensaje) { Write-Host $Mensaje -ForegroundColor Green }
function Write-Fallo([string]$Mensaje) { Write-Host $Mensaje -ForegroundColor Red }

function Get-ClaveApi {
  if ($env:GEMINI_API_KEY -and $env:GEMINI_API_KEY.Trim() -ne '') {
    return @{ Clave = $env:GEMINI_API_KEY.Trim(); Origen = 'variable de entorno GEMINI_API_KEY' }
  }
  $ficheroEnv = Join-Path $RAIZ '.env'
  if (Test-Path -LiteralPath $ficheroEnv) {
    foreach ($linea in Get-Content -LiteralPath $ficheroEnv -Encoding UTF8) {
      if ($linea -match '^\s*GEMINI_API_KEY\s*=\s*(.+?)\s*$') {
        $valor = $Matches[1].Trim().Trim('"').Trim("'")
        if ($valor -ne '') { return @{ Clave = $valor; Origen = 'fichero .env' } }
      }
    }
  }
  return $null
}

function Get-Ficha {
  param([string]$Ruta)
  if (-not $Ruta) { throw 'Falta el parámetro -Lectura.' }
  $rutaLimpia = $Ruta.TrimEnd('\', '/')
  if (Test-Path -LiteralPath $rutaLimpia -PathType Container) {
    $ficheros = Get-ChildItem -LiteralPath $rutaLimpia -Filter '*.txt' -File
    if ($ficheros.Count -eq 0) { throw "No hay fichas .txt en '$rutaLimpia'." }
    return $ficheros[0].FullName
  }
  if (Test-Path -LiteralPath $rutaLimpia -PathType Leaf) { return (Resolve-Path -LiteralPath $rutaLimpia).Path }
  throw "No existe la ruta '$Ruta'."
}

function Get-Prompts {
  param([string]$RutaFicha)
  $contenido = [System.IO.File]::ReadAllText($RutaFicha, [System.Text.Encoding]::UTF8)
  $lineas = $contenido -split "`r?`n"
  $slug = [System.IO.Path]::GetFileNameWithoutExtension($RutaFicha)

  $salida = @{}
  $actual = $null
  $pendientePrompt = $false

  foreach ($linea in $lineas) {
    # Cabecera de bloque: "■ IMAGEN MINIATURA ..." / "■ IMAGEN DE CUERPO 1 ..."
    if ($linea -match '^\s*[■]\s*(.+)$') {
      $cabecera = $Matches[1]
      if ($cabecera -match 'MINIATURA') { $actual = 'miniatura' }
      elseif ($cabecera -match 'CUERPO\s*1') { $actual = 'cuerpo1' }
      elseif ($cabecera -match 'CUERPO\s*2') { $actual = 'cuerpo2' }
      else { $actual = $null }
      if ($actual) {
        $salida[$actual] = @{ Prompt = ''; Archivo = '' }
      }
      $pendientePrompt = $false
      continue
    }
    if (-not $actual) { continue }

    if ($linea -match '^\s*-\s*Nombre de archivo\s*:\s*(.+?)\s*$') {
      $salida[$actual].Archivo = $Matches[1]
      $pendientePrompt = $false
      continue
    }
    if ($linea -match '^\s*-\s*Prompt IA[^:]*\s*:\s*(.*)$') {
      $salida[$actual].Prompt = $Matches[1].Trim()
      $pendientePrompt = ($salida[$actual].Prompt -eq '')
      continue
    }
    # Continuación del prompt en líneas siguientes
    if ($pendientePrompt) {
      if ($linea.Trim() -eq '' -or $linea -match '^\s*-\s' -or $linea -match '^\s*[■]' -or $linea -match '^-{5,}') {
        $pendientePrompt = $false
      } else {
        $salida[$actual].Prompt = (($salida[$actual].Prompt + ' ' + $linea.Trim())).Trim()
        continue
      }
    }
    # Fin de la sección 3
    if ($linea -match '^-{5,}' -and $linea -notmatch 'IMAGEN') {
      # no cortamos: puede haber más líneas de guiones dentro
    }
  }

  # Nombres por defecto si la ficha no los indica
  $defecto = @{
    miniatura = "${slug}_mini_${AnchoMini}x${AltoMini}.png"
    cuerpo1   = "${slug}_cuerpo_1.png"
    cuerpo2   = "${slug}_cuerpo_2.png"
  }
  foreach ($clave in @('miniatura', 'cuerpo1', 'cuerpo2')) {
    if ($salida.ContainsKey($clave) -and -not $salida[$clave].Archivo) {
      $salida[$clave].Archivo = $defecto[$clave]
    }
  }
  return $salida
}

function Convertir-Imagen {
  param([byte[]]$Bytes, [int]$Ancho, [int]$Alto, [switch]$Recortar)
  Add-Type -AssemblyName System.Drawing
  $entrada = New-Object System.IO.MemoryStream(, $Bytes)
  $origen = [System.Drawing.Image]::FromStream($entrada)
  try {
    if ($Recortar) {
      $ratioObjetivo = $Ancho / $Alto
      $ratioOrigen = $origen.Width / $origen.Height
      if ($ratioOrigen -gt $ratioObjetivo) {
        $corteAlto = $origen.Height
        $corteAncho = [int]([Math]::Round($corteAlto * $ratioObjetivo))
        $x = [int](($origen.Width - $corteAncho) / 2)
        $y = 0
      } else {
        $corteAncho = $origen.Width
        $corteAlto = [int]([Math]::Round($corteAncho / $ratioObjetivo))
        $x = 0
        $y = [int](($origen.Height - $corteAlto) / 2)
      }
      $destinoAncho = $Ancho
      $destinoAlto = $Alto
    } else {
      $destinoAncho = $Ancho
      $destinoAlto = [int]([Math]::Round($Ancho * $origen.Height / $origen.Width))
      $x = 0; $y = 0
      $corteAncho = $origen.Width
      $corteAlto = $origen.Height
    }

    $mapa = New-Object System.Drawing.Bitmap($destinoAncho, $destinoAlto)
    $grafico = [System.Drawing.Graphics]::FromImage($mapa)
    $grafico.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $grafico.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $grafico.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $grafico.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $grafico.DrawImage($origen,
      (New-Object System.Drawing.Rectangle(0, 0, $destinoAncho, $destinoAlto)),
      (New-Object System.Drawing.Rectangle($x, $y, $corteAncho, $corteAlto)),
      [System.Drawing.GraphicsUnit]::Pixel)
    $grafico.Dispose()

    $salida = New-Object System.IO.MemoryStream
    $mapa.Save($salida, [System.Drawing.Imaging.ImageFormat]::Png)
    $mapa.Dispose()
    return @{ Bytes = $salida.ToArray(); Ancho = $destinoAncho; Alto = $destinoAlto }
  }
  finally {
    $origen.Dispose()
    $entrada.Dispose()
  }
}

function Invoke-GeminiImagen {
  param([string]$Prompt, [string]$ApiKey, [bool]$ConRelacion)
  $cuerpo = @{
    contents        = @(@{ parts = @(@{ text = $Prompt }) })
    generationConfig = @{ responseModalities = @('IMAGE') }
  }
  if ($ConRelacion) { $cuerpo.generationConfig['imageConfig'] = @{ aspectRatio = $Relacion } }
  $json = $cuerpo | ConvertTo-Json -Depth 10
  $uri = "$BASE/models/${Modelo}:generateContent"

  try {
    $respuesta = Invoke-RestMethod -Method Post -Uri $uri `
      -Headers @{ 'x-goog-api-key' = $ApiKey } `
      -ContentType 'application/json; charset=utf-8' `
      -Body ([System.Text.Encoding]::UTF8.GetBytes($json)) `
      -TimeoutSec 300
    return @{ Ok = $respuesta }
  } catch {
    $codigo = 0
    if ($_.Exception.Response) { $codigo = [int]$_.Exception.Response.StatusCode }
    $cuerpoError = ''
    if ($_.ErrorDetails -and $_.ErrorDetails.Message) { $cuerpoError = $_.ErrorDetails.Message }
    elseif ($_.Exception.Response) {
      try {
        $lector = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $cuerpoError = $lector.ReadToEnd(); $lector.Close()
      } catch { $cuerpoError = $_.Exception.Message }
    } else { $cuerpoError = $_.Exception.Message }

    if ($codigo -eq 429 -or $cuerpoError -match 'RESOURCE_EXHAUSTED|RESOURCE_EXHAUSTED_RETRY|quota|Quota exceeded|rate limit') {
      return @{ Error = 'CUOTA'; Detalle = $cuerpoError }
    }
    if ($codigo -eq 401 -or $cuerpoError -match 'API_KEY_INVALID|UNAUTHENTICATED|PERMISSION_DENIED') {
      return @{ Error = 'CLAVE'; Detalle = $cuerpoError }
    }
    if ($codigo -eq 404 -or $cuerpoError -match 'NOT_FOUND|is not found for API version') {
      return @{ Error = 'MODELO'; Detalle = $cuerpoError }
    }
    return @{ Error = 'OTRO'; Detalle = "HTTP $codigo $cuerpoError" }
  }
}

# ---------------------------------------------------------------------------
# Comprobación de clave (sin generar imagen)
# ---------------------------------------------------------------------------

if ($ComprobarClave) {
  $cfg = Get-ClaveApi
  if (-not $cfg) {
    Write-Fallo 'No se ha encontrado la clave de API.'
    Write-Host "  1) Crea una clave gratis en https://aistudio.google.com/apikey"
    Write-Host "  2) Guárdala como variable de entorno GEMINI_API_KEY, o en el fichero .env de la raíz:"
    Write-Host "     GEMINI_API_KEY=AIza..."
    exit 1
  }
  Write-Info "Clave encontrada en: $($cfg.Origen)"
  $uriModelo = "$BASE/models/$Modelo"
  try {
    $null = Invoke-RestMethod -Method Get -Uri $uriModelo -Headers @{ 'x-goog-api-key' = $cfg.Clave } -TimeoutSec 60
    Write-Ok "El modelo '$Modelo' responde correctamente para esta clave."
    exit 0
  } catch {
    $codigo = 0
    if ($_.Exception.Response) { $codigo = [int]$_.Exception.Response.StatusCode }
    if ($codigo -eq 404) {
      Write-Aviso "El modelo '$Modelo' no está disponible para esta clave. Prueba con: -Modelo gemini-3.1-flash-lite-image"
      exit 3
    }
    if ($codigo -eq 401 -or ($_.ErrorDetails.Message -match 'API_KEY_INVALID')) {
      Write-Fallo 'La clave de API no es válida (401 / API_KEY_INVALID).'
      exit 5
    }
    Write-Fallo "Error al comprobar el modelo: HTTP $codigo $($_.ErrorDetails.Message)"
    exit 4
  }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if (-not $Lectura) { Write-Fallo 'Indica la carpeta de la lectura: -Lectura <seccion>/<slug>'; exit 4 }

try { $rutaFicha = Get-Ficha -Ruta $Lectura } catch { Write-Fallo $_.Exception.Message; exit 4 }
Write-Info "Ficha: $rutaFicha"

$prompts = Get-Prompts -RutaFicha $rutaFicha
$seleccion = @('miniatura', 'cuerpo1', 'cuerpo2')
if ($Imagen -ne 'todas') { $seleccion = @($Imagen) }

$pendientes = @()
foreach ($tipo in $seleccion) {
  if (-not $prompts.ContainsKey($tipo)) { continue }
  if (-not $prompts[$tipo].Prompt) { continue }
  $pendientes += $tipo
  Write-Info "  [$tipo] -> $($prompts[$tipo].Archivo)"
  if ($ExtractOnly) { Write-Info "     Prompt: $($prompts[$tipo].Prompt)" }
}

if ($pendientes.Count -eq 0) {
  Write-Fallo 'No se han encontrado prompts de imagen en la ficha (sección 3).'
  exit 4
}
if ($ExtractOnly) { exit 0 }

$cfg = Get-ClaveApi
if (-not $cfg) {
  Write-Fallo 'Falta la clave de API: define la variable de entorno GEMINI_API_KEY o añade GEMINI_API_KEY=... al fichero .env'
  exit 1
}
Write-Info "Usando clave de: $($cfg.Origen)"

$carpeta = Split-Path -Parent $rutaFicha
$errores = @()

foreach ($tipo in $pendientes) {
  $entrada = $prompts[$tipo]
  $destino = Join-Path $carpeta $entrada.Archivo
  Write-Info "Generando $tipo -> $($entrada.Archivo)"

  $resultado = Invoke-GeminiImagen -Prompt $entrada.Prompt -ApiKey $cfg.Clave -ConRelacion $true
  if ($resultado.ContainsKey('Error') -and $resultado.Error -eq 'OTRO' -and $resultado.Detalle -match 'imageConfig|aspectRatio|Invalid JSON payload') {
    # El modelo no admite imageConfig: reintentamos sin él
    Write-Aviso '  El modelo no admite imageConfig; reintento sin relación de aspecto.'
    $resultado = Invoke-GeminiImagen -Prompt $entrada.Prompt -ApiKey $cfg.Clave -ConRelacion $false
  }

  if ($resultado.ContainsKey('Error')) {
    switch ($resultado.Error) {
      'CUOTA' {
        Write-Aviso "  SIN CUOTA: no quedan créditos/cuota libres para generar. La cuota gratuita se recarga cada 24 h."
        $errores += @{ Tipo = $tipo; Motivo = 'CUOTA' }
      }
      'CLAVE' {
        Write-Fallo '  La clave de API no es válida (401 / API_KEY_INVALID).'
        $errores += @{ Tipo = $tipo; Motivo = 'CLAVE' }
      }
      'MODELO' {
        Write-Aviso "  El modelo '$Modelo' no está disponible para esta clave. Prueba con: -Modelo gemini-3.1-flash-lite-image"
        $errores += @{ Tipo = $tipo; Motivo = 'MODELO' }
      }
      default {
        Write-Fallo "  Error: $($resultado.Detalle)"
        $errores += @{ Tipo = $tipo; Motivo = 'OTRO' }
      }
    }
    continue
  }

  $partes = @($resultado.Ok.candidates[0].content.parts) | Where-Object { $_.inlineData -and $_.inlineData.data }
  if (-not $partes) {
    Write-Fallo '  El modelo no devolvió ninguna imagen (solo texto). Repite la generación.'
    $errores += @{ Tipo = $tipo; Motivo = 'SIN_IMAGEN' }
    continue
  }
  $bytes = [Convert]::FromBase64String($partes[0].inlineData.data)

  if ($tipo -eq 'miniatura') {
    $salida = Convertir-Imagen -Bytes $bytes -Ancho $AnchoMini -Alto $AltoMini -Recortar
  } else {
    $salida = Convertir-Imagen -Bytes $bytes -Ancho $AnchoCuerpo
  }
  [System.IO.File]::WriteAllBytes($destino, $salida.Bytes)
  Write-Ok ("  Guardada: {0} ({1} KB, {2}x{3})" -f $destino, [int]($salida.Bytes.Length / 1KB), $salida.Ancho, $salida.Alto)
}

if ($errores.Count -gt 0) {
  $motivos = $errores | ForEach-Object { $_.Motivo } | Select-Object -Unique
  if ($motivos -contains 'CUOTA' -and $motivos.Count -eq 1) { exit 2 }
  if ($motivos -contains 'CLAVE') { exit 5 }
  if ($motivos -contains 'MODELO') { exit 3 }
  exit 4
}

Write-Ok 'Imágenes generadas correctamente.'
exit 0
