<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# 3D printing conventions

## Semantic:
- Prefer a single feature that serves several functions over separate features.

## Technical:
- Give function precedence over appearance. Within that constraint, follow the project's artistic direction, with chamfered edges and rounded forms on visible surfaces.
- Design parts to print without supports: use overhangs of 45 degrees or steeper, gussets and pointed openings instead of flat bridges and floating features.
- Use pointed (V-shaped) arches for internal openings. Give openings visible from the outside (vents, slots, ports) a teardrop profile: a rounded end, with a 45-degree point at the end printed last.
- Start every support-free overhang from an already printed surface - the bed or a wall - from its first layer.
- Reinforce a weak part (overlaps at joints, fillets, thicker walls) rather than reshape it.
- Include the mounts for optional parts from the start, so the parts can be added later without a reprint.
- Check enclosure designs against the following:
  - batteries: free space on every side and above for swelling with age, no sharp features facing the cell, and an insulating wrap (e.g. Kapton tape);
  - PCB edges: at least 0.3 mm of clearance, and 1–2 mm around hand-soldered pins and parts;
  - speakers: space for the cone and its travel in front of the frame;
  - buttons: distinguishable by function (shape, colour or placement), with disruptive actions, such as power, harder to trigger by accident than the main control;
  - screws: clear of batteries and PCBs; a head facing either is round (pan) or flush with its thread.
- Mark printed models on the inside with a maker's mark naming the maker and the model. Confirm the names with the Maintainer, and never remove an existing mark.
