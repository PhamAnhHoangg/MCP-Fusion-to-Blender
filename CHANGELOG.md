# Changelog

Each change bumps the plugin version in `.claude-plugin/plugin.json`. Add a row to the README's Changelog table and rebuild the zip after every bump.

## 0.2.6 (2026-11-26)

### Added
- Claude names every new tab and keeps a numbered list of the designs it made, in order, so it knows what to close or delete.
- Test designs go into a `testing` folder in the project and are moved out when they become keepers; Claude offers to clear the folder after a round of tests.
- Closing a tab with unsaved changes asks first.

## 0.2.5 (2026-11-26)

### Fixed
- Parts sketched on the XZ plane no longer come out upside down: the skill checks which way the sketch faces before drawing and checks the bounding box after the first extrude.
- Through-hole cuts are symmetric and target the body, so they no longer fail with "No target body found".
- After a script fails halfway, Claude cleans up the half-made timeline features before retrying.

## 0.2.4 (2026-11-26)

### Docs
- README has a Changelog table listing every version and the issue it fixed.

## 0.2.3 (2026-11-26)

### Fixed
- Opening a local file no longer leaves a `*` (unsaved changes) on the tab: Claude uploads the file into the project and opens the saved design, or opens the copy already in the project, instead of importing it as a new unsaved design.

## 0.2.2 (2026-11-26)

### Fixed
- Opening a file that is already open no longer imports a duplicate (shown by Fusion as "name (1)"): Claude switches to the open design instead.

## 0.2.1 (2026-11-26)

### Fixed
- Opening a local file (STEP, STL and similar) no longer leaves an "Untitled" design: Claude names the new design after the file, then saves it.
- When the Fusion hub has no projects, Claude says the design is not saved yet and offers to create a project, instead of failing on `activeProject`.
- Project creation example now uses `app.data.activeHub.dataProjects.add(name)`.

## 0.2.0 (2026-11-26)

### Improved
- Fusion design skill: right after creating a new project or design, Claude saves it under the requested name (no more "Untitled" designs). It uses `doc.saveAs` into the chosen project (through the Fusion MCP's script tool when there is no named-save tool), checks that the name stuck, and saves again after each major modelling step.

## 0.1.0 (2026-11-26)

### Added
- Three skills: Fusion design rules for 3D printing, Blender showcase (lighting, turntable, exploded view, MP4 render), and the Fusion to Blender pipeline.
- Blender MCP config (MCP for Blender, telemetry off).
- Build scripts for the `.plugin` zip.
