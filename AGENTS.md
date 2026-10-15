# AGENTS.md — Instrucciones para agentes de IA

Este repositorio es un **proyecto editorial**: creación y adaptación de lecturas para una plataforma educativa de Educación Primaria (público: niños de **6 a 10 años**), listas para publicar en un CMS (WordPress o similar). No es un proyecto de software.

> **Fuente de verdad**: antes de empezar cualquier tarea, lee `MEMORIA_PROYECTO.md` (estado, bitácora y protocolo de reanudación).

## Orden de lectura obligatorio

1. `MEMORIA_PROYECTO.md` — estado global, decisiones y protocolo de reanudación (sección 5).
2. `guia_redaccion_y_estilo.md` — pautas editoriales y de imágenes.
3. `plantilla_cms.txt` — estructura exacta de entrega.
4. El backlog de la sección elegida: `cuentos/backlog_cuentos.md`, `fabulas/backlog_fabulas.md` o `curiosidades/backlog_curiosidades.md`.

## Reglas clave

- **Extensión**: 200 - 300 palabras por lectura.
- **Introducción**: 2-3 frases atractivas para CMS/redes, **sin desvelar el final, la moraleja ni la solución**.
- **Derechos de autor**: solo contenido de dominio público o de creación libre de derechos.
- **Estructura**: cada lectura en su propia carpeta `<seccion>/<slug>/`, con la ficha `<slug>.txt` y sus imágenes.
- **Imágenes**: `<slug>_mini_800x500.png`, `<slug>_cuerpo_1.png`, `<slug>_cuerpo_2.png` (misma carpeta, sin prefijo de categoría).

## Flujo de ejecución

1. Elegir un tema pendiente (`- [ ]`) de un backlog.
2. Redactar siguiendo `plantilla_cms.txt`.
3. Crear `cuentos|fabulas|curiosidades/<slug>/<slug>.txt` (y las imágenes, si se generan).
4. Marcar en el backlog: `- [x] ~~Título~~`.
5. Registrar la entrega en la tabla de la sección 4 de `MEMORIA_PROYECTO.md`.

`.github/copilot-instructions.md` es la versión específica para GitHub Copilot; ambos documentos deben permanecer coherentes.
