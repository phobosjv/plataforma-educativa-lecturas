# Sección: ¿Sabías qué? (Curiosidades)

En esta carpeta se gestionan artículos breves sobre ciencia, naturaleza, animales y datos fascinantes.

## Criterios Específicos:
- Temas divulgativos libres de derechos, redactados con rigor pero de forma lúdica.
- Explicación de fenómenos naturales, curiosidades del cuerpo humano y misterios de la ciencia.
- Extensión: 200 - 300 palabras.

## Estructura de entrega:
- Cada curiosidad en su propia carpeta: `curiosidades/<slug>/`.
- Dentro: `<slug>.txt` (ficha CMS) e imágenes `<slug>_mini_800x500.png`, `<slug>_cuerpo_1.png`, `<slug>_cuerpo_2.png`.

## 🔗 Enlaces sugeridos a ejercicios interactivos (CTA)

Esto aplica principalmente a las **curiosidades**. Al generar (o revisar) una curiosidad, hay que **buscar entre los ejercicios interactivos ya publicados** los que puedan relacionarse con el tema y dejarlos como **sugerencias** en el `.txt` de la lectura. El enlace definitivo lo decide y coloca el editor; el agente solo propone.

**Dónde buscar los ejercicios interactivos:**
- Listado público completo: `https://aprendeyjuega.org/api/v1/contenidos/` (no requiere autenticación).
- Quedarse con los que tengan `tipo = "interactivo"` y `publicado = true`.
- Cruzarlos con la curiosidad por **temática/etiquetas** (por ejemplo `animales`, `ropa`, `el-reloj`, `estaciones-del-ano`, `comprension-lectora`).

**Cómo dejarlo en el `.txt`:** añadir una sección `4. ENLACES SUGERIDOS (CTA)` con la lista de candidatos en el formato:

```
- [Título del ejercicio] -> https://aprendeyjuega.org/contenido/[slug]
```

**Reglas:**
- Proponer **solo ejercicios que existan realmente** (nunca inventar enlaces ni slugs).
- Si no hay ningún ejercicio relacionado, indicarlo en la sección: `Sin ejercicios interactivos relacionados.`
- Priorizar 1-4 candidatos claramente relacionados sobre una lista larga y difusa.
