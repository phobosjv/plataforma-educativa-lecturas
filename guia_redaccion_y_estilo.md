# Guía Editorial y de Publicación en CMS

Esta guía establece los criterios de redacción, diseño y formato para todas las lecturas publicadas en la plataforma educativa.

---

## 📝 1. Pautas de Redacción (Edad: 6-10 años)

- **Extensión**: Entre 200 y 300 palabras por ejercicio.
- **Estructura**:
  - Parágrafos breves (3 a 4 frases por párrafo).
  - Puntuación clara y fluida para facilitar la lectura en voz alta o silenciosa.
- **Lenguaje**: Accesible, cercano, dinámico y motivador. Si se incluye una palabra compleja, se explicará de forma natural dentro del contexto.
- **Derechos de Autor**: Todo el contenido debe ser de **dominio público** (cuentos clásicos, fábulas tradicionales) o creaciones de divulgación de libre uso.
- **Introducción / Descripción previa**:
  - Resumen atractivo de 2-3 frases para redes sociales o vista previa del CMS.
  - **REGLA DE ORO**: No revelar el desenlace, la moraleja ni la solución de la curiosidad.

---

## 🖼️ 2. Especificaciones de Imágenes y Prompts

- **Miniatura / Redes Sociales**:
  - **Resolución**: 800x500 píxeles (proporción 16:10).
  - **Enfoque**: Atractiva, colorida, que represente el concepto principal de la lectura.
- **Imágenes de Cuerpo**:
  - 1 o más imágenes intercaladas para mantener la atención del lector.
  - Indicación explícita de ubicación usando el marcador de la plantilla: `[IMAGEN 1: Colocar tras el Párrafo X — descripción corta de la escena]`.
- **Estilo de Generación por IA**:
  - Estilo: *Ilustración infantil estilo cuento ilustrado en 3D suave / acuarela digital colorida, apta para público de educación primaria, tonos cálidos, sin texto escrito en la imagen*.
  - En caso de requerir generación externa, se proporcionará el prompt detallado tanto para la miniatura como para el cuerpo.

---

## 📋 3. Formato de Entrega (.txt para CMS)

Cada lectura desarrollada se entregará en un archivo con formato uniforme según la plantilla definida en `plantilla_cms.txt`.

- **Estructura**: cada lectura tiene su propia carpeta `<seccion>/<slug>/` (ej.: `cuentos/los_tres_cerditos/`) que contiene la ficha `<slug>.txt` y sus imágenes.
- **`<slug>`**: título en minúsculas, sin acentos ni signos de puntuación, palabras separadas por guion bajo.
- **Imágenes** (misma carpeta, sin prefijo de categoría): `<slug>_mini_800x500.png`, `<slug>_cuerpo_1.png`, `<slug>_cuerpo_2.png`. La extensión real puede ser `.png` o `.jpg`.
- **Enlaces sugeridos (CTA)**: cuando existan ejercicios interactivos relacionados (típicamente en **curiosidades**), incluir en el `.txt` la sección `4. ENLACES SUGERIDOS (CTA)` con candidatos reales (título + URL). El enlace definitivo lo decide y coloca el editor; ver `curiosidades/README.md`.
