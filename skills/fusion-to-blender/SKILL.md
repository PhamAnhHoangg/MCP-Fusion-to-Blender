---
name: fusion-to-blender
description: This skill should be used when moving a design from Autodesk Fusion into Blender for a presentation, video or render, e.g. "show this Fusion part in Blender", "make a presentation video of my design", "export to Blender and animate it".
---

# Fusion to Blender pipeline

Fusion's presentation mode lags, so presentations and videos are made in Blender. Follow these steps in order and confirm with the user between stages.

## 1. Prepare in Fusion
- Follow the fusion-3d-print-design skill. Make every moving part its own component with a clear name.
- Pick the export format:
  - **FBX** for assemblies: each component stays a separate object, so parts can move on their own.
  - **OBJ** for a single part.
  - **STL** only if nothing else works: names and part separation are lost.
- Export from Fusion (File > Export), or through the Fusion MCP if it offers an export tool. Ask the user for the folder; suggest one on drive E: on Hai's PC.

## 2. Import into Blender
- FBX: `bpy.ops.import_scene.fbx(filepath=...)`. OBJ: `bpy.ops.wm.obj_import(filepath=...)`. STL (Blender 4.2+): `bpy.ops.wm.stl_import(filepath=...)`.
- Check real-world size straight away (Fusion exports often arrive in cm or mm units). Fix the scale, apply it, and centre the assembly on the origin with the lowest point at Z = 0.
- List the imported objects with their names so the user can confirm the parts arrived.

## 3. Stage, animate, render
Use the blender-showcase skill: studio scene, then one of its animation recipes, then a single test frame, then the full MP4.

## 4. When the design changes
Re-export with the same file name and re-import, keeping materials by matching object names. For frequent changes, suggest the free Fusion to Blender Bridge add-in (GPL), which syncs geometry and keeps Blender materials.

## Ground rules
- Never use screen control on the user's computer. Hai does any clicks in Fusion or Blender; Claude works through the MCP servers or gives written steps.
- Everything must stay free. Ask before suggesting any paid add-in or asset.
