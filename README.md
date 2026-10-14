# Proyecto de Lecturas Infantiles (6 a 10 años)
## Plataforma Educativa de Educación Primaria

¡Bienvenido al proyecto de generación y edición de lecturas infantiles! Este proyecto está diseñado para crear contenido educativo, entretenido y adaptado pedagógicamente a niños de entre 6 y 10 años para su publicación en un CMS (WordPress o similar).

---

## 📁 Estructura del Proyecto

```
proyecto_lecturas/
├── README.md                          # Visión general y reglas del proyecto
├── MEMORIA_PROYECTO.md                # Bitácora, memoria persistente e historial de entregas
├── guia_redaccion_y_estilo.md         # Pautas editoriales, formato CMS e instrucciones para imágenes
├── plantilla_cms.txt                  # Plantilla base en texto plano para importar al CMS
├── .github/
│   └── copilot-instructions.md        # Instrucciones automáticas para agentes y sesiones
├── cuentos/
│   ├── README.md                      # Instrucciones específicas de la sección Cuentos
│   └── backlog_cuentos.md             # Lista de cuentos clásicos de dominio público
├── fabulas/
│   ├── README.md                      # Instrucciones específicas de la sección Fábulas
│   └── backlog_fabulas.md             # Lista de fábulas tradicionales de dominio público
└── curiosidades/
    ├── README.md                      # Instrucciones específicas de la sección ¿Sabías qué?
    └── backlog_curiosidades.md        # Lista de temas de ciencia, naturaleza e historia
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
3. **Entrega de Ficheros**:
   - Fichero `.txt` listo para copiar en el CMS.
   - Prompts e imágenes en resolución 800x500 px (miniatura) y cuerpo del texto.
4. **Actualización del Backlog y Memoria**: La lectura completada se marcará como tachada (`- [x] ~~Título~~`) en el backlog correspondiente y se registrará en `MEMORIA_PROYECTO.md`.
