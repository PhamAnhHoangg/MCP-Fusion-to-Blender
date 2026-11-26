---
name: fusion-3d-print-design
description: This skill should be used when designing, modifying or reviewing a part in Autodesk Fusion (Fusion 360), especially through the Fusion MCP server or for 3D printing, e.g. "create a new project or design in Fusion", "model a bracket in Fusion", "make this printable", "add threads", "set up joints".
---

# Designing in Fusion for 3D printing

Follow these rules when building or reviewing a Fusion design. They come from Hai's "53 Autodesk Fusion tips" reference video.

## New projects and designs: save and name them at once
A new Fusion design opens as "Untitled" and is not saved anywhere until someone saves it. Whenever you create a new project or design, save it under the requested name immediately, before modelling anything.

1. **New project** (user asks for a project): create it in the active hub, e.g. `app.data.activeHub.dataProjects.add(name)`, and make it the active project.
2. **New design**: create the document, then save it straight away into that project's root folder (or the active project if none was named), e.g. `doc.saveAs(name, project.rootFolder, '', '')`. Use the Fusion MCP's own create/save tools if it offers them; otherwise run the Fusion API through its script or code tool.
3. **Name**: use exactly the name the user gave. If they gave none, ask for one; if they say any name is fine, use `design-YYYY-MM-DD-HHMM`.
4. **Check**: read back the active document's name and confirm it is no longer "Untitled" and shows as saved. Tell the user the project and design name.
5. After that, save again (`doc.save('<short description>')`) at the end of each major modelling step so the timeline is never lost.
6. **Opening a local file** (STEP, STP, STL, IGES, F3D): first look through `app.documents` for an open design with the file's name; if one is there, activate it and stop, never open a second copy (Fusion would show it as "name (1)").
7. **Open it as a saved design, not an import**: `importManager.importToNewDocument` builds a brand-new unsaved design, so the tab shows `*` (unsaved changes) the moment it opens. Instead, if the target project's root folder already holds a design with the file's name, open that with `app.documents.open(dataFile)`. Otherwise upload the file with `project.rootFolder.uploadFile(path)`, wait until `uploadState == adsk.core.UploadStates.UploadFinished`, then open the resulting `dataFile`. The design opens saved, named after the file, with no `*`.
8. **No project to save into**: `app.data.activeProject` throws when the hub has no projects. Check `app.data.activeHub.dataProjects.count` first. If it is 0, ask the user for a project name and create it with `app.data.activeHub.dataProjects.add(name)`; never create one without asking. If they decline, import instead, set `doc.name` to the file name, and tell them the tab shows `*` because it is not saved yet.

## Keep track of what Claude creates
1. **Name every new tab**: each time you create or open a design, tell the user its name and its project and folder. Keep a numbered list in the order you made them ("Made by Claude: 1. test-bracket, 2. test-bracket-v2, ...") and show it again whenever it changes.
2. **Closing tabs**: `doc.close(False)` closes without saving, so unsaved changes are lost. If `doc.isModified` is true, ask before closing; otherwise close freely.
3. **Deleting designs**: delete only designs on that list or ones the user names, newest first unless told otherwise, and always ask first. A deleted design goes to Fusion's web Trash.
4. **Test designs go in a `testing` folder**: anything made to try something out is saved into `<project>/testing` (create it with `rootFolder.dataFolders.add('testing')` if missing), never the project root. When the user says a test design is a keeper, move it out with `dataFile.move(project.rootFolder)`. When a round of tests ends, list the testing folder and offer to delete what is in it. In a new chat, the testing folder is the record of what was made for tests.

## Modelling workflow
- Build parts as sketch + extrude. Sketch on existing faces when adding features.
- Prefer a sketched circle + extrude cut over the Hole tool when exact control matters.
- **Sketch direction**: a sketch's own axes do not always match the model's. On the XZ construction plane, sketch +Y points to model -Z, so a profile drawn "up" in the sketch comes out upside down. Before drawing, check with `sketch.sketchToModelSpace(Point3D(0, 1, 0))` (minus the sketch origin) which model direction sketch +Y points, and draw so the part goes where asked (upright = +Z). After the first extrude, check the bounding box min and max, not only its size.
- **Through cuts**: use `setAllExtent(SymmetricExtentDirection)` and set `participantBodies` to the target body, so a sketch whose normal faces the other way still cuts. A one-sided "all" cut fails with "No target body found" when it points away from the body.
- **Failed script halfway**: list the timeline and delete the features it left behind before retrying, so no half-made sketches or cuts stay in the design.
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
