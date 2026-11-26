---
name: blender-showcase
description: This skill should be used when staging, animating or rendering a product or CAD model in Blender through the Blender MCP, e.g. "make a turntable video", "exploded view animation", "render this part nicely", "camera fly-through", "studio lighting".
---

# Showcasing a model in Blender

Use the Blender MCP's code tool (`execute_blender_code`) to run `bpy` scripts. Work in small steps, check each step with the viewport or screenshot tool, and ask the user to save their .blend file before large changes.

## Before anything
1. Read `bpy.app.version`. Blender 4.2 to 4.x names Eevee `BLENDER_EEVEE_NEXT`; earlier and 5.x use `BLENDER_EEVEE`. Pick the one that exists in `bpy.types.RenderSettings.bl_rna.properties['engine'].enum_items`.
2. Get the scene summary. Never delete objects the user did not ask about.

## Scene setup (studio look)
- Units: metric, scale 1.0. Check the model's real size with its dimensions; CAD exports often arrive 10x or 1000x off. Fix with object scale, then apply scale.
- Shade smooth with "smooth by angle" (about 30 degrees) so CAD meshes don't look faceted.
- Floor: a large plane with a soft grey material, or a curved backdrop (a plane bent with a bevelled edge).
- Lighting: three area lights (key 45 degrees front-left and strongest, fill front-right at about a third, rim from behind). Or use a world HDRI if the user has one.
- Materials: Principled BSDF. Plastic (roughness 0.4, a clear colour), brushed metal (metallic 1, roughness 0.3), PLA print (roughness 0.6).
- Camera: 50 to 85 mm focal length, framed so the object fills about 70% of the frame, with depth of field off unless asked.

## Animation recipes
Before keyframing, set `bpy.context.preferences.edit.keyframe_new_interpolation_type = 'LINEAR'` for constant-speed motion (and restore it afterwards). This works across Blender versions without touching the F-curve API.

- **Turntable:** create an Empty at the object's centre, parent the model to it, keyframe Z rotation 0 at frame 1 and 360 degrees at the last frame. 10 s at 30 fps = 300 frames.
- **Exploded view:** for each part, compute the direction from the assembly centre to the part centre. Keyframe the assembled position, then the part moved outward along that direction by 0.5 to 1 times the assembly size, then back. Stagger start frames by 5 to 10 frames per part. Use Bezier easing for this one.
- **Camera orbit or fly-through:** add a Bezier circle or curve path, give the camera a Follow Path constraint plus a Track To constraint aimed at the Empty.
- **Gear train:** drive the second gear's rotation with a driver equal to `-ratio * var` of the first gear's rotation.

## Rendering
- Eevee for previews and most videos; Cycles for final hero stills. On a 4 GB GPU keep Cycles samples near 128 with denoising on.
- Video output: FFmpeg, MPEG-4 container, H.264, quality High, 1920x1080, 30 fps. Write to a folder the user names; never overwrite an existing file without asking.
- Render a single frame first and show it before rendering the full animation.
