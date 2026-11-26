# Changelog

Each change bumps the plugin version in `.claude-plugin/plugin.json`. Rebuild the zip after every bump.

## 0.2.0 (2026-11-26)

### Improved
- Fusion design skill: right after creating a new project or design, Claude saves it under the requested name (no more "Untitled" designs). It uses a Fusion API script for the first save, because the Autodesk Fusion MCP's save operation cannot set a name. It then checks that the name stuck, and saves again after each major modelling step.

## 0.1.0 (2026-11-26)

### Added
- Three skills: Fusion design rules for 3D printing, Blender showcase (lighting, turntable, exploded view, MP4 render), and the Fusion to Blender pipeline.
- Blender MCP config (MCP for Blender, telemetry off).
- Build scripts for the `.plugin` zip.
