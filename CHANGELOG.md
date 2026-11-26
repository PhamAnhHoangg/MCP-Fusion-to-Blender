# Changelog

Each change bumps the plugin version in `.claude-plugin/plugin.json`. Rebuild the zip after every bump.

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
