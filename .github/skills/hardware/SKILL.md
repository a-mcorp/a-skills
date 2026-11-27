---
name: hardware
description: Enforce the hardware project guidelines.
---
<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->

# Semantic
- Treat measurements taken by hand as the reference for every part. The makers' values are checked against them.

# Technical
- Record the reasoning in `DESIGN.md`, not in the `README.md`. Write each decision as a short, impersonal point: a bold label naming what was settled on, then a short reason.
- Keep the CAD in four roles, in any tool and any number of files: parts (each bought part, with measured dimensions), layout (the single source of truth for positions and clearances, read by everything else), printable parts (exported with one switch choosing the part) and assembly with fit checks. A measured value then changes in one place.
- Render previews in the orientation the Operator sees the part from, and state which side the view shows.
- Keep the layout and tools of the hardware repository (e.g. `cad/`, `bom/`, `circuits/`, `docs/`, `exports/`).

# Extensions
- Read `.github/skills/hardware/Dimensions.md` when measuring parts, or entering dimensions in the CAD files or the bill of materials.
- Read `.github/skills/hardware/BOM.md` when working with a bill of materials.
- Read `.github/skills/hardware/Printing.md` when designing parts for 3D printing.
- Read `.github/skills/hardware/Photos.md` when adding photos to the documentation.
