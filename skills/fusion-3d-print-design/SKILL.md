---
name: fusion-3d-print-design
description: This skill should be used when designing, modifying or reviewing a part in Autodesk Fusion (Fusion 360), especially through the Fusion MCP server or for 3D printing, e.g. "model a bracket in Fusion", "make this printable", "add threads", "set up joints".
---

# Designing in Fusion for 3D printing

Follow these rules when building or reviewing a Fusion design. They come from Hai's "53 Autodesk Fusion tips" reference video.

## Modelling workflow
- Build parts as sketch + extrude. Sketch on existing faces when adding features.
- Prefer a sketched circle + extrude cut over the Hole tool when exact control matters.
- Drive key sizes with user parameters (`length`, `width`, `wall`) and expressions (`length = width / 2`) so the design can be resized later.
- Fully constrain sketches (dimensions, midpoint, horizontal/vertical, diameter) before extruding.
- Use construction lines for reference geometry; they never form profiles.
- Fix mistakes by editing the original step in the timeline, not by stacking new features on top.
- Add fillets and chamfers to outside edges: they look better and make parts stronger.
- Hollow parts with Shell. Cut a part exactly in half with a midplane construction plane + Split Body.
- Use Loft between different profiles. Use Sweep with a guide rail when a 3D path makes the profile twist.
- Emboss puts text or logos onto curved faces.

## Components and assemblies
- Use components for anything that moves or is a separate physical part; bodies are geometry inside one component.
- Ground (pin) one component, or the whole assembly moves together.
- Prefer as-built joints when parts already sit in place. Revolute for a gear on an axle; cylindrical if it should also slide.
- Capture Position after dragging components if the new position should stick.
- Couple joints with motion links (for example a 2:1 gear ratio).
- Name every component clearly: the names survive export to Blender (see the fusion-to-blender skill).

## 3D-printing rules
- Overhangs: aim for 45 to 50 degrees from vertical; 60 is the practical limit and prints worse and slower.
- Flat horizontal spans can bridge without supports.
- Clearance between separate printed parts: 0.2 mm for an accurate printer (tight), 0.4 mm for a loose fit. Below 0.2 mm parts tend to fuse.
- Threads: Create > Thread with Modeled ticked. Add clearance by shelling a copy of the threaded part outward by about 0.2 mm and subtracting it. For difficult threads, print with small layers (about 0.08 mm) or scale non-uniformly in Z by 1.5 to 2.
- Check internal clearances with Section Analysis before printing.
- Print-in-place hinges and wheels need the clearance rules on every moving gap.
- Export for printing with Save as Mesh, STL, refinement High.

## Check the work
- After each major step, measure (bounding box, wall thickness, hole diameters) and compare with the request. Report the numbers.
- For standard screws and nuts, suggest importing models from McMaster-Carr rather than modelling them by hand.
