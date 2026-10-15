# Proyecto de Lecturas Infantiles (6 a 10 años)
## Plataforma Educativa de Educación Primaria

¡Bienvenido al proyecto de generación y edición de lecturas infantiles! Este proyecto está diseñado para crear contenido educativo, entretenido y adaptado pedagógicamente a niños de entre 6 y 10 años para su publicación en un CMS (WordPress o similar).

---

## 📁 Estructura del Proyecto

```
proyecto_lecturas/
├── README.md                          # Visión general y reglas del proyecto
├── AGENTS.md                          # Instrucciones para agentes de IA (fuente de verdad: MEMORIA)
├── MEMORIA_PROYECTO.md                # Bitácora, memoria persistente e historial de entregas
├── guia_redaccion_y_estilo.md         # Pautas editoriales, formato CMS e instrucciones para imágenes
├── plantilla_cms.txt                  # Plantilla base en texto plano para importar al CMS
├── .gitignore                         # Exclusiones de control de versiones
├── .github/
│   └── copilot-instructions.md        # Instrucciones automáticas para GitHub Copilot
├── cuentos/
│   ├── README.md                      # Instrucciones específicas de la sección Cuentos
│   ├── backlog_cuentos.md             # Lista de cuentos clásicos de dominio público
│   └── <slug>/                        # Una carpeta por lectura
│       ├── <slug>.txt                 # Ficha CMS de la lectura
│       ├── <slug>_mini_800x500.png    # Miniatura / redes sociales
│       └── <slug>_cuerpo_1.png        # Imagen de cuerpo (y _cuerpo_2.png si procede)
├── fabulas/
│   ├── README.md                      # Instrucciones específicas de la sección Fábulas
│   ├── backlog_fabulas.md             # Lista de fábulas tradicionales de dominio público
│   └── <slug>/                        # Una carpeta por lectura (misma estructura)
└── curiosidades/
    ├── README.md                      # Instrucciones específicas de la sección ¿Sabías qué?
    ├── backlog_curiosidades.md        # Lista de temas de ciencia, naturaleza e historia
    └── <slug>/                        # Una carpeta por lectura (misma estructura)
```

---

## 🎯 Tipos de Lecturas

1. **Cuentos**: Adaptaciones de cuentos clásicos y populares libres de derechos de autor.
2. **Fábulas**: Relatos tradicionales con moraleja o enseñanza explícita.
3. **¿Sabías qué? (Curiosidades)**: Artículos divulgativos breves sobre ciencia, naturaleza, el cuerpo humano y datos sorprendentes.

---

## 🔄 Flujo de Trabajo

1. **Selección del Backlog**: Se elegirá una lectura pendiente de `cuentos/backlog_cuentos.md`, `fabulas/backlog_fabulas.md` o `curiosidades/backlog_curiosidades.md`.
2. **Desarrollo del Contenido**: Se generará la lectura cumpliendo rigurosamente los requisitos de extensión (200-300 palabras), vocabulario e imágenes.
3. **Entrega de Ficheros** (dentro de la subcarpeta `<seccion>/<slug>/` de la lectura):
   - Fichero `<slug>.txt` listo para copiar en el CMS.
   - Prompts e imágenes en resolución 800x500 px (miniatura) y cuerpo del texto.
4. **Actualización del Backlog y Memoria**: La lectura completada se marcará como tachada (`- [x] ~~Título~~`) en el backlog correspondiente y se registrará en `MEMORIA_PROYECTO.md`.
