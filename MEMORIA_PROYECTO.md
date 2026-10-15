# 🧠 Memoria y Bitácora del Proyecto: Plataforma Educativa de Lecturas

Este documento constituye la **memoria viva y persistente** del proyecto. Permite a cualquier asistente, editor o desarrollador retomar el trabajo en sesiones futuras, en diferentes entornos o equipos de trabajo, manteniendo absoluta coherencia pedagógica, editorial y técnica.

---

## 📌 1. Ficha Resumen del Proyecto

| Parámetro | Detalle |
| :--- | :--- |
| **Público Objetivo** | Educación Primaria (niños de 6 a 10 años) |
| **Destino de Contenidos** | Publicación en CMS (WordPress o plataforma similar) |
| **Extensión de Lecturas** | 200 a 300 palabras por ejercicio |
| **Categorías** | 1. Cuentos Clásicos \| 2. Fábulas Tradicionales \| 3. Curiosidades (¿Sabías qué?) |
| **Resolución Miniatura / RRSS** | 800 x 500 px (horizontal) |
| **Formato de Entrega** | Ficheros `.txt` basados en `plantilla_cms.txt` con prompts/imágenes asociadas |
| **Directrices y Estilo** | Definidos en `guia_redaccion_y_estilo.md` y `.github/copilot-instructions.md` |

---

## 📊 2. Estado Global de los Backlogs

| Categoría | Carpeta | Fichero de Backlog | Total Temas | Desarrollados | Pendientes |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **Cuentos** | `cuentos/` | `cuentos/backlog_cuentos.md` | 17 | 5 | 12 |
| **Fábulas** | `fabulas/` | `fabulas/backlog_fabulas.md` | 15 | 2 | 13 |
| **Curiosidades** | `curiosidades/` | `curiosidades/backlog_curiosidades.md` | 20 | 6 | 14 |
| **TOTAL** | — | — | **52** | **13** | **39** |

---

## 📁 3. Convenciones de Archivos y Carpetas

**Regla general:** cada lectura vive en su **propia subcarpeta** dentro de su sección, y dentro de ella van tanto la ficha `.txt` como sus imágenes.

1. **Carpeta de la lectura**:
   - Ubicación: `<seccion>/<slug>/` (ejemplo: `cuentos/los_tres_cerditos/`).
   - El `<slug>` es el título en minúsculas, sin acentos ni signos de puntuación, con las palabras separadas por guion bajo (*snake_case*).
2. **Ficha de Lectura (`.txt`)**:
   - Nombre: `<slug>.txt`, guardado dentro de la carpeta de la lectura.
   - Ejemplos: `cuentos/los_tres_cerditos/los_tres_cerditos.txt`, `fabulas/la_liebre_y_la_tortuga/la_liebre_y_la_tortuga.txt`, `curiosidades/por_que_los_flamencos_son_rosas/por_que_los_flamencos_son_rosas.txt`.
3. **Archivos de Imagen** (en la misma carpeta de la lectura, con el `<slug>` como única base, **sin prefijo de categoría**):
   - Miniatura destacada: `<slug>_mini_800x500.png`
   - Imagen de cuerpo 1: `<slug>_cuerpo_1.png`
   - Imagen de cuerpo 2: `<slug>_cuerpo_2.png`
   - Las imágenes **sí se versionan** (son entregables del proyecto).
   - **Generación**: se crean automáticamente a partir de los prompts de la sección 3 de la ficha con `tools/generar_imagenes.ps1` o el subagente `imagenes` (ver `tools/README.md`).

---

## 📝 4. Bitácora Histórica de Lecturas Desarrolladas

> Cada vez que se desarrolle una nueva lectura, debe registrarse aquí una nueva fila con sus datos y marcarse como completada en su backlog respectivo.

| # | Fecha | Categoría | Título de la Lectura | Fichero Generado | Palabras | Miniatura (800x500) | Imágenes Cuerpo | Estado CMS |
| :-: | :---: | :---: | :--- | :--- | :-: | :---: | :---: | :---: |
| 1 | 2026-09-06 | Curiosidad | ¿Por qué los gorros de lana tienen ese pompón tan gracioso? | `curiosidades/por_que_los_gorros_de_lana_tienen_ese_pompon_tan_gracioso/por_que_los_gorros_de_lana_tienen_ese_pompon_tan_gracioso.txt` | 127 | No | 1 | Publicada |
| 2 | 2026-09-13 | Curiosidad | ¿Por qué el pulpo tiene tres corazones? | `curiosidades/por_que_el_pulpo_tiene_tres_corazones/por_que_el_pulpo_tiene_tres_corazones.txt` | 127 | No | 1 | Publicada |
| 3 | 2026-09-20 | Curiosidad | ¿Por qué los relojes de los anuncios marcan las 10:10? | `curiosidades/por_que_los_relojes_de_los_anuncios_marcan_las_10_10/por_que_los_relojes_de_los_anuncios_marcan_las_10_10.txt` | 73 | No | 1 | Publicada |
| 4 | 2026-09-27 | Cuento | Los músicos de Bremen | `cuentos/los_musicos_de_bremen/los_musicos_de_bremen.txt` | 352 | Sí | 3 | Publicada |
| 5 | 2026-09-27 | Curiosidad | ¿Por qué las ardillas esconden bellotas en otoño? | `curiosidades/por_que_las_ardillas_esconden_bellotas_en_otono/por_que_las_ardillas_esconden_bellotas_en_otono.txt` | 101 | Sí | 1 | Publicada |
| 6 | 2026-09-28 | Cuento | Cenicienta | `cuentos/cenicienta/cenicienta.txt` | 394 | Sí | 3 | Publicada |
| 7 | 2026-10-03 | Cuento | Hansel y Gretel | `cuentos/hansel_y_gretel/hansel_y_gretel.txt` | 381 | Sí | 2 | Publicada |
| 8 | 2026-10-04 | Curiosidad | ¿Por qué titilan las estrellas? | `curiosidades/por_que_titilan_las_estrellas/por_que_titilan_las_estrellas.txt` | 134 | Sí | 1 | Publicada |
| 9 | 2026-10-05 | Fábula | El león y el ratón | `fabulas/el_leon_y_el_raton/el_leon_y_el_raton.txt` | 223 | Sí | 2 | Publicada |
| 10 | 2026-10-10 | Cuento | El Patito Feo | `cuentos/el_patito_feo/el_patito_feo.txt` | 305 | Sí | 3 | Publicada |
| 11 | 2026-10-11 | Curiosidad | ¿Por qué aparece el arcoíris cuando llueve y sale el sol? | `curiosidades/por_que_aparece_el_arcoiris_cuando_llueve_y_sale_el_sol/por_que_aparece_el_arcoiris_cuando_llueve_y_sale_el_sol.txt` | 95 | Sí | 1 | Publicada |
| 12 | 2026-10-12 | Cuento | El sastrecillo valiente | `cuentos/el_sastrecillo_valiente/el_sastrecillo_valiente.txt` | 263 | Sí | 2 | Publicada |
| 13 | 2026-10-15 | Fábula | La liebre y la tortuga | `fabulas/la_liebre_y_la_tortuga/la_liebre_y_la_tortuga.txt` | 282 | Prompt | 2 (prompt) | Generada (pendiente publicación) |

> Las 12 lecturas anteriores ya estaban publicadas en el CMS; se han volcado al repositorio (texto e imágenes) el 2026-10-15 como registro retroactivo. La extensión de algunas supera el rango recomendado de 200-300 palabras (publicadas así en el CMS); se anota como observación.

---

## 🚀 5. Protocolo de Reanudación de Trabajo (Paso a Paso)

Cuando inicies una nueva sesión de trabajo (en este o en cualquier otro equipo):

1. **Lectura de Memoria**: Consultar `MEMORIA_PROYECTO.md` para verificar qué lecturas han sido generadas y cuáles son las siguientes en prioridad.
2. **Selección del Tema**: Consultar el backlog deseado (`cuentos/backlog_cuentos.md`, `fabulas/backlog_fabulas.md` o `curiosidades/backlog_curiosidades.md`) y elegir una lectura pendiente (`- [ ]`).
3. **Generación del Contenido**:
   - Usar la estructura de `plantilla_cms.txt`.
   - Cuidar que el texto esté entre **200 y 300 palabras**.
   - Redactar una descripción de 2-3 frases atractivas para redes/vista previa **sin desvelar el final/moraleja**.
   - Incluir los prompts de imagen (estilo ilustración infantil 3D suave / acuarela, sin texto).
4. **Guardar el Archivo**: Crear la carpeta `<seccion>/<slug>/` y dentro el archivo `<slug>.txt`.
5. **Generar las Imágenes**: delegar en el subagente **`imagenes`** (`.opencode/agents/imagenes.md`) o ejecutar `tools\generar_imagenes.ps1 -Lectura <seccion>/<slug>` (ver `tools/README.md`). Lee los prompts de la sección 3 de la ficha y guarda los PNG en su carpeta. **Si no hay cuota/créditos libres** (código de salida `2`), dejar la imagen como *pendiente (sin cuota)* y decírselo al editor; puede generarse a mano con el mismo prompt cuando la cuota se recargue (cada 24 h).
6. **Actualizar Registros**:
   - Tachar la tarea en el backlog (`- [x] ~~Título~~`).
   - Añadir la fila correspondiente en la tabla de la Sección 4 de esta `MEMORIA_PROYECTO.md`.

---

## 💡 6. Registro de Decisiones Editoriales

- **2026-10-14**: Creación de `.github/copilot-instructions.md` y `MEMORIA_PROYECTO.md` para persistencia contextual entre múltiples sesiones, entornos y modelos.
- **2026-10-14**: Estandarización de nombres en *snake_case* para los ficheros `.txt` y las imágenes de cada lectura.
- **2026-10-14**: Regla de longitud fija de 200 a 300 palabras validada para todos los ejercicios para adecuarse al tiempo de atención de 6-10 años.
- **2026-10-15**: Cada lectura se organiza en su propia subcarpeta `<seccion>/<slug>/` que contiene la ficha `<slug>.txt` y sus imágenes; se elimina el prefijo de categoría en los nombres de imagen. Se unifica la convención de nombres en todos los documentos y se añade `AGENTS.md` y `.gitignore`.
- **2026-10-15**: Registro retroactivo de las 12 lecturas ya publicadas en el CMS (`aprendeyjuega.org`): se volcó su contenido (ficha + imágenes) a su subcarpeta correspondiente y se marcaron como hechas en los backlogs. 7 de ellas no estaban en el backlog original y se añadieron ya completadas (Cenicienta y El sastrecillo valiente en Cuentos; 5 curiosidades). Se conserva la extensión real de las imágenes (`.png`/`.jpg`).
- **2026-10-15**: Nueva regla editorial: al generar (o revisar) una **curiosidad**, buscar entre los ejercicios interactivos publicados los relacionados con el tema y proponerlos como enlaces CTA en la sección `4. ENLACES SUGERIDOS (CTA)` del `.txt` de la lectura. El enlace final lo decide y coloca el editor. Procedimiento detallado en `curiosidades/README.md`; se refleja también en `plantilla_cms.txt`, `guia_redaccion_y_estilo.md` y `AGENTS.md`.
- **2026-10-15**: Primera lectura generada de principio a fin por el flujo nuevo: *La liebre y la tortuga* (`fabulas/la_liebre_y_la_tortuga/`), 282 palabras, con prompts de imagen y sugerencia CTA (interactivo *Cuentos clásicos*, etiquetado `liebre-y-tortuga`).
- **2026-10-15**: **Automatización de la generación de imágenes con Nano Banana** (modelos de imagen de Google: `gemini-3.1-flash-image`, «Nano Banana 2»; alternativa económica `gemini-3.1-flash-lite-image`). Se añaden `tools/generar_imagenes.ps1` (lee los prompts de la sección 3 de la ficha, llama a la API de Google y guarda el PNG: miniatura recortada a 800x500 y cuerpo a 1200 px de ancho) y el subagente `.opencode/agents/imagenes.md`. La clave de API vive en la variable de entorno `GEMINI_API_KEY` o en un fichero `.env` no versionado (añadido a `.gitignore`); nunca se versiona ni se comparte. Si **no hay cuota/créditos libres** el script devuelve el código `2`, la imagen se marca como *pendiente (sin cuota)* y el editor puede generarla a mano con el mismo prompt; no se reintenta en bucle. Documentación completa en `tools/README.md`.
