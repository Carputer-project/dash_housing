# dash_housing

3D printed dash housing for the **Waveshare ESP32-S3-Touch-LCD-7** carputer.

OpenSCAD source plus STL exports. `dash_housing.scad` is the **design** — everything in `st/` is
exported from it, so edit the `.scad`, not the meshes.

**Firmware that runs in this housing lives in [`esp32_ms_dash`](https://github.com/Carputer-project/esp32_ms_dash).**

---

## Parts

Five printed pieces, plus one printed twice:

| Part | Export | Qty | Notes |
|---|---|---|---|
| Front bezel | `-D 'export_part="bezel"'` | 1 | Holds the glass, 4× corner M3 |
| Rear tub | `-D 'export_part="rear_tub"'` | 1 | Fan well, exhaust, cable exit, all bosses |
| Side strip | `-D 'export_part="plate_side"'` | **2** | One part prints both sides |
| Screen mount plate | `-D 'export_part="screen_plate"'` | 1 | Behind the LCD, 2 × M3 into the strips |
| Bracket | `-D 'export_part="bracket"'` | 1 | Rear pole mount, 4 × M4 |

`st/dash_housing.stl` is the whole assembly in one file — **use it for viewing only**. A printer or
slicer will reject it: it is five separate bodies, which is correct, not a defect.

## Build

```
openscad -D 'export_part="rear_tub"' -o st/rear_tub_dfm.stl dash_housing.scad
```

Headless PNG export:

```
DISPLAY=:0 openscad -D 'export_part="rear_tub"' -o view.png \
  --imgsize=1600,1100 --projection=p --camera=0,0,0,72,0,20,340 \
  --autocenter --viewall dash_housing.scad
```

View flags at the top of the file: `show_assembled`, `show_stack`, `show_rear_tub`, etc.

## Current version — v3.8

- **Finned exhaust port** on the bottom edge: 8 slots × 8 mm between 9 × 4 mm fins. Replaces a
  single ~117 mm (≈4.6 in) open slot. The cable gets its own small 15 × 9 mm hole beside it.
- **iobox3 PCB mount** — 2 bossed standoffs at the board's own 2 × M2 (2.1 mm) holes, plus 2
  anti-tilt pads. Both board holes are on the *same* edge, so the pads stop the board tilting.
  Board is **87.6 × 76.7 × 1.6 mm**. Bracket boss pattern widened 70 → 120 mm so the board fits.
- **Fan at the rear-wall top centre.** Its M3 holes cut through the wall only, with bosses behind
  them flush with the PCB underside.
- **All interior bosses are embedded 1.5 mm into the cavity floor** so they fuse into one solid.
  Cylinders sitting exactly flush on the floor export as *separate shells*, which print services
  reject as "structure is separate."
- Clash-checked against the exported mesh: **0 interferences**.

## Printing

- No supports needed — the cavity is drafted 1° and everything pulls straight from the back.
- 3–4 perimeters, ~40% infill.
- 2.5 mm walls throughout.

## Things to check against your own hardware

The parameters at the top of `dash_housing.scad` are **defaults, not measured**:

- `waveshare_stack_thickness` (8–12 mm) — **caliper your actual unit**
- Fan frame thickness (10 or 20 mm)
- `draft_angle`, `box_corner_r`, `wall`

Everything keys off `fan_well_x` / `fan_well_y`, so moving the fan is a two-number change.

## Notes

- The 25 MB `esp32-s3-touch-lcd-7.stp` vendor solid is intentionally **not** committed. The PDF and
  `waveshare_drawing.png` carry the dimensions it was taken from.
- Rendered previews for v3.8: `pcb_fit_v38.png` (board in place), `exhaust_v37_*.png` (the grille),
  `assembled_v37_*.png`.

## Licence

No licence file — add one before publishing publicly.