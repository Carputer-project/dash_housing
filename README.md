# dash_housing

3D printed dash housing for the **Waveshare ESP32-S3-Touch-LCD-7** carputer.

Firmware: [`esp32_ms_dash`](https://github.com/Carputer-project/esp32_ms_dash)

`dash_housing.scad` is the design. Everything in `st/` is exported from it — edit the `.scad`.

## Parts

| Part | Export name | Qty |
|---|---|---|
| Front bezel | `bezel` | 1 |
| Rear tub | `rear_tub` | 1 |
| Side strip | `plate_side` | **2** |
| Screen mount plate | `screen_plate` | 1 |
| Bracket | `bracket` | 1 |

## Build

```
openscad -D 'export_part="rear_tub"' -o st/rear_tub_dfm.stl dash_housing.scad
```

`st/dash_housing.stl` is all five parts in one file — for viewing only. A printer will reject it
because it is five separate bodies.

## Print

3–4 perimeters, 40% infill, no supports.