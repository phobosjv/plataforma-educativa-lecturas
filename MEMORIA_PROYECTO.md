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
| **Cuentos** | `cuentos/` | `cuentos/backlog_cuentos.md` | 15 | 0 | 15 |
| **Fábulas** | `fabulas/` | `fabulas/backlog_fabulas.md` | 15 | 0 | 15 |
| **Curiosidades** | `curiosidades/` | `curiosidades/backlog_curiosidades.md` | 15 | 0 | 15 |
| **TOTAL** | — | — | **45** | **0** | **45** |

---

## 📁 3. Convenciones de Archivos y Carpetas

Para asegurar orden al exportar o importar en el CMS:
1. **Ficha de Lectura (`.txt`)**:
   - Se guardará en la carpeta correspondiente a su sección (`cuentos/`, `fabulas/`, `curiosidades/`).
   - Nombrado en minúsculas y sin espacios (formato *snake_case*):
     - Ejemplos: `cuentos/los_tres_cerditos.txt`, `fabulas/la_liebre_y_la_tortuga.txt`, `curiosidades/por_que_flamencos_rosa.txt`.
2. **Archivos de Imagen**:
   - Miniatura destacada: `[slug]_mini_800x500.png`
   - Imagen de cuerpo 1: `[slug]_cuerpo_1.png`
   - Imagen de cuerpo 2: `[slug]_cuerpo_2.png`

---

## 📝 4. Bitácora Histórica de Lecturas Desarrolladas

> Cada vez que se desarrolle una nueva lectura, debe registrarse aquí una nueva fila con sus datos y marcarse como completada en su backlog respectivo.

| # | Fecha | Categoría | Título de la Lectura | Fichero Generado | Palabras | Miniatura (800x500) | Imágenes Cuerpo | Estado CMS |
| :-: | :---: | :---: | :--- | :--- | :-: | :---: | :---: | :---: |
| — | — | — | *Ninguna lectura desarrollada aún* | — | — | — | — | Pendiente inicio |

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
4. **Guardar el Archivo**: Crear el archivo `.txt` en la carpeta temática correspondiente.
5. **Actualizar Registros**:
   - Tachar la tarea en el backlog (`- [x] ~~Título~~`).
   - Añadir la fila correspondiente en la tabla de la Sección 4 de esta `MEMORIA_PROYECTO.md`.

---

## 💡 6. Registro de Decisiones Editoriales

- **2026-10-14**: Creación de `.github/copilot-instructions.md` y `MEMORIA_PROYECTO.md` para persistencia contextual entre múltiples sesiones, entornos y modelos.
- **2026-10-14**: Estandarización de nombres en *snake_case* para los ficheros `.txt` y las imágenes de cada lectura.
- **2026-10-14**: Regla de longitud fija de 200 a 300 palabras validada para todos los ejercicios para adecuarse al tiempo de atención de 6-10 años.
