# tools/ — Utilidades del proyecto

## `generar_imagenes.ps1`

Genera las imágenes de una lectura con **Nano Banana** (modelos de imagen de Google: por defecto `gemini-3.1-flash-image`, «Nano Banana 2») y las guarda directamente en la carpeta de la lectura, con la convención del proyecto:

| Imagen | Nombre de archivo | Tratamiento |
| :--- | :--- | :--- |
| Miniatura / RRSS | `<slug>_mini_800x500.png` | Recorte centrado + ajuste a 800x500 |
| Cuerpo 1 | `<slug>_cuerpo_1.png` | Ancho 1200 px, sin recorte |
| Cuerpo 2 | `<slug>_cuerpo_2.png` | Ancho 1200 px, sin recorte |

Los prompts se leen automáticamente de la sección `3. ESPECIFICACIONES DE IMÁGENES Y PROMPTS PARA IA` de la ficha `<slug>.txt`.

### Configuración (una sola vez)

1. Crea una clave gratis en <https://aistudio.google.com/apikey> (tier gratuito con cuota diaria de imágenes).
2. Guárdala en **una** de estas dos opciones:
   - Variable de entorno de usuario: `GEMINI_API_KEY`
   - Fichero `.env` en la **raíz del repositorio** (ya está en `.gitignore`):

     ```
     GEMINI_API_KEY=AIza...
     ```

> La clave **nunca** se versiona ni se pega en el chat. Si la cambias, no hace falta reiniciar nada si usas el fichero `.env`.

### Uso

```powershell
# Comprobar que la clave y el modelo responden (no gasta cuota de imagen)
powershell -NoProfile -ExecutionPolicy Bypass -File tools\generar_imagenes.ps1 -ComprobarClave

# Generar todas las imágenes de una lectura
powershell -NoProfile -ExecutionPolicy Bypass -File tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga

# Solo una imagen
powershell -NoProfile -ExecutionPolicy Bypass -File tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga -Imagen miniatura

# Ver los prompts que se enviarían, sin llamar a la API
powershell -NoProfile -ExecutionPolicy Bypass -File tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga -ExtractOnly

# Otro modelo (más económico)
powershell -NoProfile -ExecutionPolicy Bypass -File tools\generar_imagenes.ps1 -Lectura fabulas/la_liebre_y_la_tortuga -Modelo gemini-3.1-flash-lite-image
```

### Códigos de salida

| Código | Significado | Acción |
| :---: | :--- | :--- |
| 0 | Todo correcto | Verificar los `.png` y actualizar `MEMORIA_PROYECTO.md`. |
| 1 | Falta la clave de API | Configurar `GEMINI_API_KEY` (ver arriba). |
| 2 | **Sin cuota/créditos libres** | Esperar: la cuota gratuita se recarga cada 24 h. Mientras tanto, la imagen puede generarse a mano con el prompt de la ficha. |
| 3 | Modelo no disponible para esa clave | Probar con `-Modelo gemini-3.1-flash-lite-image`. |
| 4 | Sin prompts en la ficha u otro error | Revisar la sección 3 del `.txt`. |
| 5 | Clave inválida | Regenerar la clave en AI Studio. |

### Uso desde el asistente

En lugar de ejecutar el script a mano, se puede pedir al subagente **`imagenes`** (definido en `.opencode/agents/imagenes.md`), que sigue el flujo completo: comprueba la clave, genera, revisa el resultado y actualiza la bitácora de `MEMORIA_PROYECTO.md`.
