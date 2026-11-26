# Fusion to Blender

A Claude plugin for designing parts in Autodesk Fusion and turning them into smooth presentation videos in Blender (turntables, exploded views, camera fly-throughs). Fusion's presentation mode lags; Blender renders clean MP4s.

Everything here is free.

## What's inside

| Part | What it does |
| --- | --- |
| `skills/fusion-3d-print-design` | Design rules for Fusion: parameters, constraints, components vs bodies, joints, and 3D-printing rules (overhangs, clearances, threads) |
| `skills/blender-showcase` | Studio lighting, materials, turntable / exploded-view / camera recipes, and MP4 render settings for Blender |
| `skills/fusion-to-blender` | The pipeline: export from Fusion (FBX / OBJ), import and fix scale in Blender, animate, render |
| `.mcp.json` | Connects Claude to Blender through [MCP for Blender](https://github.com/ahujasid/blender-mcp) (MIT), telemetry off |

Fusion is reached through Autodesk's own Fusion MCP server, which is built into Fusion (see setup step 2).

## Setup on Windows

1. **uv** (runs the Blender MCP server): `winget install --id=astral-sh.uv -e`, then open a new terminal. C: is tight on this PC, so keep its cache on E:: `setx UV_CACHE_DIR E:\uv-cache`.
2. **Fusion MCP** (built in): in Fusion, profile icon > Preferences > General > API > tick **Fusion MCP Server** > Apply. Then add the "Autodesk Fusion" connector in Claude.
3. **Blender add-on**: run `uvx mcp-for-blender install-addon`, then in Blender: Edit > Preferences > Add-ons > enable "MCP for Blender". In the 3D viewport press N, open the MCP for Blender tab, click **Start MCP Server**.
4. **Install this plugin**: build the zip (below) and add `dist\fusion-to-blender.plugin` to Claude.

## Build the plugin zip

```powershell
powershell -ExecutionPolicy Bypass -File scripts\build-plugin.ps1
```

(or `scripts/build-plugin.sh` on macOS/Linux). After changing anything, bump `version` in `.claude-plugin/plugin.json`, add an entry to [CHANGELOG.md](CHANGELOG.md) and a row to the Changelog table below, rebuild, and re-add the plugin.

## Changelog

Latest first. Full details in [CHANGELOG.md](CHANGELOG.md).

| Version | Type | What changed |
| --- | --- | --- |
| 0.2.5 | Fixed | Parts sketched on the XZ plane came out upside down and through-holes failed to cut: sketch direction is checked first and cuts go both ways |
| 0.2.4 | Docs | README now lists the changelog |
| 0.2.3 | Fixed | Opening a local file left a `*` (unsaved) tab: it is now uploaded into the project and opened as a saved design |
| 0.2.2 | Fixed | Opening a file that was already open imported a duplicate ("name (1)"): Claude now switches to the open design |
| 0.2.1 | Fixed | Opened files stayed "Untitled": the design is now named after the file. Hubs with no project no longer crash on `activeProject` |
| 0.2.0 | Improved | New projects and designs are saved under the requested name right away, no more "Untitled" |
| 0.1.0 | Added | First release: three skills, Blender MCP config, build scripts |

## Safety

Both MCP servers run code inside Fusion and Blender on this computer, on localhost only. Save your work before asking Claude for big changes.

## Roadmap

- Our own Fusion MCP server (Python add-in + MCP server) with tools tuned for 3D printing, plus an evaluation against Autodesk's server.
- More Blender recipes (gear trains from Fusion motion links, assembly sequences).
