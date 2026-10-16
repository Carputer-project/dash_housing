// 7" Dash Housing — OpenSCAD parametric model
// Based on: how_to_md_files/ms_dash_housing_builder.md
// Render with OpenSCAD (F5 preview, F6 render, F7 export STL)
//
// v3 (2026-10-07): mold-DFM rework + hardware scrub
//   - small GC9A01A round screens REMOVED (v2) — main 7" display only
//   - real draft on the inner cavity (outer walls stay vertical so the
//     bezel and tub rim mate flush); bottom wall corrected to uniform 2.5
//   - outer corners rounded R10 (bezel + tub) / R8 (bracket)
//   - 4 corner screw bosses grafted INTO the side walls (no free-standing
//     posts); screw/pilot centers at ±104 / ±64
//   - fan EXHAUST put back: 4-bar guard grille across the rear Ø34 airflow
//   - iobox3 mounting holes: none — interior has fan screws + shell screws
//     only
//   - v3.1: bezel thinned 17 -> 14.5 (lip 2.0, pocket +1 over 10mm stack,
//     back slack 1.5)
//   - v3.2: bezel 14.5 -> 10mm (1 cm). Stack is 10mm, so the bore encloses
//     the board's front ~6.5mm and the board back pokes 2mm into the open
//     tub cavity — clearance checked, no interference.
//   - v3.3: NEW screen mount plate (screen_plate.stl): 195x113x3 plate behind
//     the board inside the tub; 4x M3 clearance at the LCD backframe pattern
//     65.65 x 126.2 (+/-63.1 / +/-32.825) + 4x M3 clearance over new tub
//     pillars at +/-88 / +/-40 (plate front face 5.5mm behind the board back,
//     clear of all back-side parts; pillars stand on the cavity floor, clear
//     of the fan well). Screen M3s thread plate -> board -> LCD backframe.
//   - v3.3 fix: drafted_box cavity cut was anchored at mid-box, leaving a
//     12.5mm solid bottom (floor at z=0 instead of the inner wall plane) —
//     the tub now has a true 2.5mm bottom and the 22.5mm-deep cavity; plus
//     4x rear-wall bosses at the bracket M4 pattern so the bracket's M4 bolts
//     self-tap into solid material (the old 12.5mm wall did that for free).
//   - v3.4: screen_mount_plate de-bulked to a mounting frame — the big center
//     slab is cut out (110.2 x 49.65 opening, R6) so the plate is just the 8
//     screw anchors + a band around them; and the fan well moved to the lower-
//     left rear wall (clear of the board's hot center) — the guard grille bars
//     and M3 pass-throughs all key off fan_well_x / fan_well_y.
//   - v3.5: screen_mount_plate split into TWO side brackets (left = mirrored
//     right) — each upright strip carries its 2 LCD-pattern M3 holes (±63.1 /
//     ±32.825) + 2 pillar M3 holes (±88 / ±40); the entire center slab and
//     frame band are gone (bbox 195 x 96 x 3). One printed part (plate_side)
//     makes both sides. Export "plate_side" for a single strip.
//   - v3.6: exhaust port now reads as a real grille — guard upgraded to 6 bars
//     @30° and the fan duct bore shortened to stop FLUSH at the inner wall face
//     (the old bore punched a blind duct ~9.5mm into the cavity, hiding the
//     grille). Grille visible from both sides now. Assembly views also draw a
//     visual-only board+LCD slab (board_stack_ref, never exported) so the
//     display's position is obvious (show_stack = z-exploded full stack).
//   - v3.7: the big open slot on the bottom edge (was a ~117mm "cable exit")
//     is now a FINNED EXHAUST PORT — a row of slots leaves fins between them
//     so the opening reads as a grille, not a gaping hole (air blown onto the
//     screen by the intake fan exits here). The cable gets its own SMALL
//     Cat6-sized hole, not that 4-inch slot.
//   - v3.8: iobox3 PCB + fan TOGETHER. Fan is at the TOP CENTRE.
//     * Fan well, 4x M3 clearance holes and the grille are all back in.
//     * Fan M3 holes cut THROUGH THE WALL ONLY (was 12.5 deep, which punched
//       9.5mm tubes into the cavity — those would have gone straight through
//       the new PCB). Screws now thread into 4 new bosses behind them.
//     * Those boss tops are FLUSH WITH THE PCB UNDERSIDE. The 2 lower holes sit
//       over the board (y=+28, board top edge +43.815), so the bosses support
//       the PCB rather than piercing it.
//     * Bracket boss pattern widened 70 -> 120 (bosses +-35 -> +-60). The board
//       is 76.708 wide and only 67.5mm was clear either side of the old bosses,
//       so it physically could not sit between them.
//     * PCB mount added: 2 bossed standoffs at the board's own 2x M2 (2.1mm)
//       holes + 2 plain anti-tilt pads. Both board holes are on the LEFT edge,
//       so the pads stop it tilting. Board underside sits 4.5mm off the floor.
//     * Board outline + hole positions read off FCP/iobox3pcb/CARPUTER.kicad_pcb
//       and confirmed against the ordered part (87.6 x 76.7 x 1.6mm).
//     * Clash-checked against the exported tub mesh: 0 interferences.
//
// MEASURE YOUR HARDWARE FIRST and adjust these parameters:
// - waveshare_stack_thickness: LCD+touch+PCB stack (8-12mm typical)
// - fan_thickness: 10mm or 20mm frame

/* [Parameters] */
// ===== MEASURE THESE ON YOUR UNITS =====
waveshare_stack_thickness = 10;    // [8:12] Total thickness of Waveshare board+LCD+touch stack (mm)
fan_thickness = 10;                // [10,20] Fan frame thickness: 10 or 20 (mm)

// ===== HOUSING GEOMETRY (from spec) =====
wall = 2.5;                        // Nominal wall thickness (mm)
draft_angle = 1.0;                 // Draft on the inner cavity (deg); outer stays vertical for flush mate
box_corner_r = 10;                 // Outer corner radius, bezel + tub (mm)

// Waveshare 7" center
ws_board_w = 192.96;               // Board width (mm)
ws_board_h = 110.76;               // Board height (mm)
ws_opening_w = 170;                // Front opening width (mm)
ws_opening_h = 100;                // Front opening height (mm)
ws_pocket_w = 195;                 // Pocket width behind opening (board + clearance)
ws_pocket_h = 113;                 // Pocket height behind opening

// Fan (40mm, M3 @ 32x32)
fan_size = 40;                     // Fan frame size (mm)
fan_mount_spacing = 32;            // M3 hole spacing (mm)
fan_well_rim = 0.5;                // Recessed rim seat depth (mm)

// Bracket mount (rear). v3.8: width 70 -> 120 so the bosses clear the iobox3
// PCB (76.708 wide). With the bosses at +-35 only 67.5mm was clear each side,
// and the board is 76.708 — it could not dodge them, so they moved out.
bracket_pattern_w = 120;           // M4 pattern width (mm)
bracket_pattern_h = 30;            // M4 pattern height (mm)
bracket_hole_dia = 4.5;            // M4 clearance hole (mm)

// iobox3 PCB (v3.8) — outline + the 2x M2 (2.1mm) mounting holes on its LEFT
// edge, read off FCP/iobox3pcb/CARPUTER.kicad_pcb and confirmed against the
// ordered board (87.6 x 76.7 x 1.6mm). Positions are relative to board centre.
pcb_w = 76.708;                    // mm
pcb_h = 87.630;                    // mm
pcb_t = 1.6;                       // mm
pcb_mh1 = [-35.052, -38.735];      // M2 hole 1
pcb_mh2 = [-35.306,  40.767];      // M2 hole 2
pcb_standoff = 4.5;                // board underside above the cavity floor (mm)
pcb_boss_d = 6;                    // standoff / boss OD (mm)
pcb_boss_h = 6;                    // boss height incl. embed (mm)
pcb_pad_d = 6;                     // plain anti-tilt pad OD (mm)
pcb_pad_h = 6;                     // pad height incl. embed (mm)
pcb_m2_pilot_d = 1.7;              // M2 self-tap pilot (mm)
pcb_m2_pilot_depth = 4;            // blind — must not break into the rear wall
pcb_antitilt = [[35.052, -38.735], [35.306, 40.767]]; // plain pads, no holes

// Screen mount plate (behind the LCD, screws to the 4x M3 back pattern)
// Waveshare ESP32-S3-Touch-LCD-7 drawing: 4x M3 at 126.2 x 65.65
plate_lcd_dx = 126.2;              // M3 pattern spacing X (mm)
plate_lcd_dy = 65.65;              // M3 pattern spacing Y (mm)
plate_lcd_hole = 3.4;              // M3 clearance hole (mm)
plate_w = ws_pocket_w;             // 195
plate_h = ws_pocket_h;             // 113
plate_t = 3;                       // plate thickness (mm)
plate_r = 8;                       // plate corner radius (mm)
plate_pillar_x = 88;               // tub pillar X (plate attach) (mm)
plate_pillar_y = 40;               // tub pillar Y (mm)
plate_pillar_d = 8;                // pillar diameter (mm)
plate_attach_hole = 3.2;           // plate hole over pillar tops (M3) (mm)
plate_pillar_pilot = 2.5;          // M3 self-tap pilot in pillars (mm)
plate_face_gap = 5.5;              // plate front face behind board back (mm)
// Side-bracket strips (v3.5): two upright brackets, one per side. Each carries
// the 2 LCD-pattern M3 holes (±63.1 / ±32.825) and the 2 pillar M3 holes
// (±88 / ±40). Left strip = the right strip mirrored; one part prints both.
plate_side_outer = ws_pocket_w/2;      // 97.5 — outer edge matches the old footprint
plate_side_inner = plate_lcd_dx/2 - 9; // 54.1 — 9mm band inboard of the LCD ring
plate_side_y = 48;                     // ±48 — 8mm past the pillar holes (±40)
strip_r = 6;                           // strip end corner radius (mm)

// Overall housing
bezel_d = 10;                      // Front bezel total depth (1 cm)
bezel_lip = 2.0;                   // Front bezel lip height holding glass
bezel_back_slack = 1.5;            // Bezel material behind the board pocket
rear_tub_depth = 25;               // Rear tub depth behind front face (mm)
cable_exit_h = 15;                 // Cable exit height at bottom rear (mm)

// Material / print
$fn = 64;                          // Circle resolution

// ===== DERIVED / INTERNAL =====
// Bore (pocket) depth: the 10mm board stack is deeper than the bezel, so the
// pocket encloses the board's front and its back pokes ~2mm into the open tub
// cavity (22.5mm clearance — no interference).
ws_pocket_depth = bezel_d - bezel_lip - bezel_back_slack; // 6.5mm bore + 1mm side clearance around board

// Fan well position (rear wall) — v3.8: TOP CENTRE, so it draws from the top
// and the air crosses the board down to the finned exhaust on the bottom edge.
// Y is limited by the 40mm frame: centre +44 leaves 5mm to the top edge (+69).
// The lower pair of M3 holes lands at y=+28, which is OVER the PCB (top edge
// +43.815) — so those holes get short bosses flush with the board underside.
fan_well_x = 0;
fan_well_y = 44;
fan_m3_boss_d = 6;                 // boss OD behind each M3 fan hole
fan_m3_pilot_d = 2.5;              // M3 self-tap pilot
fan_m3_pilot_depth = 4;            // blind, stops short of the board underside

// Exhaust port (bottom edge) — ONE finned opening. The slots are cut and the
// material left between them reads as fins, so it's a grille not a big gap.
exhaust_port_w = 110;             // overall finned port width (mm)
exhaust_port_h = cable_exit_h;    // port height (mm) — same 15mm as before
exhaust_fin_w  = 4;               // fin (bar) width (mm)
exhaust_slot_w = 8;               // open slot between fins (mm)

// Cable exit (bottom edge) — small, Cat6 only (was a ~117mm slot = ~4.6in)
cable_hole_w = 15;                // mm
cable_hole_h = 9;                 // mm
cable_hole_x = 64;                // mm — offset from the finned exhaust

// ===== MODULES =====

// Rounded-corner slab: w x h x th, corner radius r, centered at origin.
// (offset() rounds the square corners; linear_extrude gives the height.)
module rrect_slab(w, h, r, th) {
    translate([0, 0, -th/2])
        linear_extrude(height=th)
            offset(r=r) square([w - 2*r, h - 2*r], center=true);
}

// Drafted box: straight outer walls (rounded corners), inner cavity drafted
// WIDER toward the rim/open face so the core pulls clean. The cavity cut
// starts at the inner floor (uniform `wall_thick` bottom wall) and flares to
// the rim at the open end. Fixed v3.3: the floor used to sit at mid-box
// (+12.5mm solid bottom); now it lands on a true 2.5mm wall.
module drafted_box(outer_w, outer_h, outer_d, wall_thick=wall, draft=draft_angle, corner_r=box_corner_r) {
    base = wall_thick;                      // wall at the closed end
    inner_floor = -outer_d/2 + base;        // cavity floor plane
    f = tan(draft) * (outer_d - 2*base);    // inner flare over the cavity depth
    difference() {
        // Outer shell: straight sides, rounded corners
        rrect_slab(outer_w, outer_h, corner_r, outer_d);
        // Inner cavity: drafted toward the rim (open end); opens past the top
        hull() {
            translate([0, 0, inner_floor])
                rrect_slab(outer_w - 2*wall_thick, outer_h - 2*wall_thick,
                           corner_r - wall_thick, 0.01);
            translate([0, 0, outer_d/2])
                rrect_slab(outer_w - 2*wall_thick + 2*f, outer_h - 2*wall_thick + 2*f,
                           corner_r - wall_thick, 0.01);
        }
    }
}

// Fan well cut solid (subtract from rear wall): 0.5mm rim seat + airflow opening.
// NOTE: as a subtractor this must be SOLID — holes subtracted inside it would
// invert into pins blocking the fan. M3 holes are cut separately in rear_tub().
module fan_well(size=fan_size, rim=fan_well_rim) {
    // Rim seat: fan flange sits flush in the rear wall face
    translate([-size/2, -size/2, 0])
        cube([size, size, rim], center=false);
    // Airflow opening through the wall — FLUSH (v3.6): the bore used to be
    // fan_thickness deep, punching a blind duct ~9.5mm into the cavity and
    // hiding the guard grille. It now stops at the inner wall face so the
    // grille reads from both sides. Fan blades live OUTSIDE the box, so the
    // wall-depth port is fully clear of them (same airflow).
    translate([0, 0, 0])
        cylinder(d=size - 6, h=wall + 0.02, center=false);
}

// Fan exhaust guard (v3.6): 6 bars at 30° across the Ø34 airflow opening,
// flush with the wall — a proper grille, not a sparse asterisk. Printable
// (bars bridge the wall aperture), keeps the exhaust path open (~44% diameter
// covered vs 29% before; fine for a 40mm carputer fan). Bars fill only the
// wall thickness — they must NOT extend into the box where the fan blades spin.
module fan_exhaust_grille(size=fan_size, bar_w=2.5) {
    for (a = [0:30:150]) {
        rotate([0, 0, a])
            translate([-(size - 6)/2, -bar_w/2, -0.01])
                cube([size - 6, bar_w, wall + 0.02], center=false);
    }
}

// Exhaust port fins (bottom edge). One opening, cut as a row of slots so the
// material left between them is a row of fins — a grille, not a gaping hole.
module exhaust_fins(total_w=exhaust_port_w, h=exhaust_port_h, fin_w=exhaust_fin_w, slot_w=exhaust_slot_w) {
    pitch = fin_w + slot_w;
    n = max(1, floor((total_w - fin_w) / pitch));   // number of open slots
    used = n*slot_w + (n+1)*fin_w;                  // total finned-port width
    x0 = -used/2;                                    // left edge (symmetric)
    for (i = [0 : n-1])
        translate([x0 + fin_w + i*pitch, -wall/2, 0])
            cube([slot_w, wall + 1.5, h], center=false); // +1.5: cut through the drafted wall
}

// Cable exit (bottom edge) — small, Cat6 only.
module cable_exit(width=cable_hole_w, height=cable_hole_h) {
    translate([-width/2, -wall/2, 0])
        cube([width, wall + 1.5, height], center=false); // +1.5: cut through the drafted wall
}

// Bracket mount plate (rear) — rounded corners R8
module bracket_plate(pattern_w=bracket_pattern_w, pattern_h=bracket_pattern_h, hole_d=bracket_hole_dia) {
    plate_w = pattern_w + 20;
    plate_h = pattern_h + 20;
    plate_t = 5;
    difference() {
        rrect_slab(plate_w, plate_h, 8, plate_t);
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * pattern_w/2, dy * pattern_h/2, -plate_t/2 - 1]) // 0.5 past bottom face
                cylinder(d=hole_d, h=plate_t + 2, center=false);
        }
    }
}

// Screen mount — two side brackets (v3.5). The old solid plate (then framed
// plate) is split into an upright strip per side; the whole center is gone.
// Each strip rides just behind the board in the tub: 2x M3 to the LCD
// backframe pattern (65.65 x 126.2) on its inboard edge + 2x M3 down into the
// tub pillars (±88 / ±40) on its outboard edge.
module plate_side() {
    w = plate_side_outer - plate_side_inner;        // 43.4
    h = 2 * plate_side_y;                           // 96
    cx = (plate_side_outer + plate_side_inner) / 2; // 75.8 — strip center X
    difference() {
        rrect_slab(w, h, strip_r, plate_t);

        // 2x M3 clearance at the LCD backframe pattern (inboard): abs x 63.1
        for (dy = [-1, 1])
            translate([plate_lcd_dx/2 - cx, dy * plate_lcd_dy/2, 0])
                cylinder(d=plate_lcd_hole, h=plate_t + 2, center=true);

        // 2x M3 clearance over the tub pillars (outboard): abs x 88
        for (dy = [-1, 1])
            translate([plate_pillar_x - cx, dy * plate_pillar_y, 0])
                cylinder(d=plate_attach_hole, h=plate_t + 2, center=true);
    }
}

module screen_mount_plate() {
    // Right strip + left = mirrored: the same printed part serves both sides.
    cx = (plate_side_outer + plate_side_inner) / 2;
    translate([ cx, 0, 0]) plate_side();
    translate([-cx, 0, 0]) mirror([1, 0, 0]) plate_side();
}

// ===== MAIN ASSEMBLY =====

// Front bezel (main display only) — rounded R10, drafted bore, 4 corner screws
module front_bezel() {
    bezel_w = ws_pocket_w + 2*wall + 20; // 220
    bezel_h = ws_pocket_h + 2*wall + 20; // 138
    screw_x = bezel_w/2 - 6;             // ±104
    screw_y = bezel_h/2 - 5;             // ±64  (clears the R10 corner fillets)

    difference() {
        rrect_slab(bezel_w, bezel_h, box_corner_r, bezel_d);

        // Stepped bore: board pocket through the back wall, drafted (wider at
        // the back face so the core pulls), stopping at the lip
        hull() {
            translate([0, 0, bezel_d/2 - bezel_lip]) // lip end of the pocket
                rrect_slab(ws_pocket_w, ws_pocket_h, 5, 0.01);
            translate([0, 0, -bezel_d/2])            // back face (drafted wider)
                rrect_slab(ws_pocket_w + 0.3, ws_pocket_h + 0.3, 5, 0.01);
        }

        // Show window through the front lip (active area 154x86 -> window 170x100)
        translate([0, 0, bezel_d/2 - bezel_lip/2])
            cube([ws_opening_w, ws_opening_h, bezel_lip + 2], center=true);

        // 4 corner shell screws (M3) — land in the rear tub post bosses
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * screw_x, dy * screw_y, 0])
                cylinder(d=3.2, h=bezel_d + 2, center=true);
        }
    }
}

// Rear tub (rounded R10, drafted cavity, fan well + exhaust grille,
// cable exits, bracket mount). NO iobox3 mounting holes.
module rear_tub() {
    tub_w = ws_pocket_w + 2*wall + 20; // 220
    tub_h = ws_pocket_h + 2*wall + 20; // 138
    tub_d = rear_tub_depth;
    screw_x = tub_w/2 - 6;             // ±104
    screw_y = tub_h/2 - 5;             // ±64
    post_d = 9;                        // corner boss OD (grafted into side walls)
    post_pilot_d = 2.5;                // M3 self-tap pilot
    pilot_depth = 15;
    z_back = -tub_d / 2;               // rear wall outer face
    inner_floor = z_back + wall;       // inner cavity floor plane (-10)
    embed = 1.5;                       // sink pillars/bosses into the floor so the
                                       // union fuses them into ONE solid (flush-on-floor
                                       // cylinders export as separate shells -> DFM "separate structure")
    plate_face_z = tub_d/2 - 2 - plate_face_gap; // board back pokes 2mm -> plate front +5.0

    difference() {
        union() {
            // Main tub — drafted cavity, rounded corners
            drafted_box(tub_w, tub_h, tub_d);

            // 4 corner screw bosses: grafted INTO the side walls, base embedded
            // in the rear wall, tops flush with the rim (part of the housing,
            // not free-standing columns)
            for (dx = [-1, 1], dy = [-1, 1]) {
                translate([dx * screw_x, dy * screw_y, z_back + 2.0])
                    cylinder(d=post_d, h=tub_d - 2.0, center=false);
            }

            // 4 mount pillars for the screen-mount plate: stand on the cavity
            // floor, top at the plate's front face level (+5.0). Clear of the
            // fan well (±17) and the corner shell posts (±104/±64).
            for (dx = [-1, 1], dy = [-1, 1]) {
                translate([dx * plate_pillar_x, dy * plate_pillar_y, inner_floor - embed])
                    cylinder(d=plate_pillar_d, h=plate_face_z - inner_floor + embed, center=false);
            }

            // 4 rear-wall bosses at the bracket M4 pattern (±60/±15): through
            // holes in the 2.5mm wall are too thin to self-tap, so the screws
            // thread into these interior bosses instead.
            for (dx = [-1, 1], dy = [-1, 1]) {
                translate([dx * bracket_pattern_w/2, dy * bracket_pattern_h/2, inner_floor - embed])
                    cylinder(d=10, h=7 + embed, center=false);
            }

            // v3.8 — iobox3 PCB mount: 2 bossed standoffs at the board's own M2
            // holes, plus 2 plain pads on the opposite edge. The board only has
            // 2 holes and BOTH are on its left edge, so without the pads it
            // would sit on one side and tilt. Boss tops = board underside
            // (floor + pcb_standoff).
            for (mh = [pcb_mh1, pcb_mh2]) {
                translate([mh[0], mh[1], inner_floor - embed])
                    cylinder(d=pcb_boss_d, h=pcb_boss_h, center=false);
            }
            for (pad = pcb_antitilt) {
                translate([pad[0], pad[1], inner_floor - embed])
                    cylinder(d=pcb_pad_d, h=pcb_pad_h, center=false);
            }

            // v3.8 — bosses behind the fan's 4x M3 holes. The 2.5mm rear wall is
            // too thin to self-tap, so the screws need a core to bite into.
            // Tops are deliberately FLUSH WITH THE BOARD UNDERSIDE
            // (floor + pcb_standoff) so the lower pair — which sits over the
            // PCB — supports it instead of piercing it.
            for (dx = [-1, 1], dy = [-1, 1]) {
                translate([fan_well_x + dx * fan_mount_spacing/2,
                           fan_well_y + dy * fan_mount_spacing/2, inner_floor - embed])
                    cylinder(d=fan_m3_boss_d, h=pcb_standoff + embed, center=false);
            }
        }

        // ---- v3.8: fan at TOP CENTRE ----
        // Fan well in the rear wall: 0.5 rim seat + airflow opening
        translate([fan_well_x, fan_well_y, z_back])
            fan_well();

        // Fan M3 clearance holes — THROUGH THE WALL ONLY. The original ran them
        // fan_thickness+rim+2 = 12.5 deep, which punched 9.5mm tubes into the
        // cavity; with the PCB now 4.5mm off the floor those tubes would go
        // straight through the board. Screws now thread into the bosses below.
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([fan_well_x + dx * fan_mount_spacing/2,
                       fan_well_y + dy * fan_mount_spacing/2, z_back])
                cylinder(d=3.4, h=wall + 0.02, center=false);
        }

        // Exhaust port (bottom edge) — one finned opening (grille, not a hole)
        translate([0, -tub_h/2 + wall/2, z_back])
            exhaust_fins();

        // Small cable exit (bottom edge) — Cat6 only, beside the fins
        translate([cable_hole_x, -tub_h/2 + wall/2, z_back])
            cable_exit();

        // M3 pilot holes in the corner bosses (blind — floor at inner cavity)
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * screw_x, dy * screw_y, tub_d/2 - pilot_depth])
                cylinder(d=post_pilot_d, h=pilot_depth, center=false);
        }

        // M3 pilots in the plate-mount pillars (from the top face down 8mm)
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * plate_pillar_x, dy * plate_pillar_y, plate_face_z])
                cylinder(d=plate_pillar_pilot, h=8, center=false);
        }

        // M4 through pilots for the bracket bolts (outer face -> into the boss)
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * bracket_pattern_w/2, dy * bracket_pattern_h/2, z_back])
                cylinder(d=3.4, h=15, center=false);
        }

        // v3.8 — M2 self-tap pilots for the iobox3 PCB. Blind: drilled DOWN from
        // the boss top (inner_floor + pcb_standoff - pcb_boss_h + pcb_standoff =
        // -5.5) for pcb_m2_pilot_depth, ending at -9.5 — clear of the 2.5mm rear
        // wall, which starts at -10.
        for (mh = [pcb_mh1, pcb_mh2]) {
            translate([mh[0], mh[1], inner_floor + pcb_standoff - pcb_m2_pilot_depth])
                cylinder(d=pcb_m2_pilot_d, h=pcb_m2_pilot_depth, center=false);
        }

        // v3.8 — M3 self-tap pilots UP into the fan bosses, from the cavity
        // floor. Blind: 4mm from z=-10 stops at -6, 0.5mm short of the boss top
        // and 1.5mm clear of the board underside.
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([fan_well_x + dx * fan_mount_spacing/2,
                       fan_well_y + dy * fan_mount_spacing/2, inner_floor])
                cylinder(d=fan_m3_pilot_d, h=fan_m3_pilot_depth, center=false);
        }
    }

    // v3.8: fan exhaust guard grille — back in with the fan.
    translate([fan_well_x, fan_well_y, z_back])
        fan_exhaust_grille();
}

// Bracket plate (separate print)
module bracket_mount() {
    translate([0, 0, -5]) // Behind rear tub
        bracket_plate();
}

// Tub dimensions (needed for exploded view layout)
tub_w = ws_pocket_w + 2*wall + 20;
tub_h = ws_pocket_h + 2*wall + 20;
tub_d = rear_tub_depth;

// ===== RENDER SWITCHES =====
// Set to 1 to render that part, 0 to hide
show_front_bezel = 1;
show_rear_tub = 1;
show_bracket = 1;
show_screen_plate = 1;
show_assembled = 0;    // Set to 1 to see assembled (bezel + tub + plate + bracket)
show_stack = 0;        // Set to 1 for the z-exploded full-stack view (renders only)
board_stack_visible = 1; // Show the board+LCD slab in show_stack/assembled views (NOT exported)

// Visual ONLY (never exported): the Waveshare board+LCD stack, drawn in the
// stack/assembled views so it's obvious where the display sits. Front face of
// the slab lands on the bezel lip's back (z=+3, lip 2.0 deep) when positioned
// at z=-2.
module board_stack_ref() {
    color("steelblue", 0.9)
        rrect_slab(ws_board_w, ws_board_h, 6, waveshare_stack_thickness);
}

// Exploded view offset
exploded = 0;
explode_z = 30;

// Export a single part at the origin (for STL export / preview of one part):
//   "all" renders the exploded layout (default). Use CLI:
//   openscad -D 'export_part="bezel"'        -o bezel.stl        dash_housing.scad
//   openscad -D 'export_part="rear_tub"'     -o rear_tub.stl     dash_housing.scad
//   openscad -D 'export_part="bracket"'      -o bracket.stl      dash_housing.scad
//   openscad -D 'export_part="screen_plate"' -o screen_plate.stl dash_housing.scad
//   openscad -D 'export_part="plate_side"'   -o plate_side.stl   dash_housing.scad  (print 2x)
export_part = "all"; // "all" | "bezel" | "rear_tub" | "bracket" | "screen_plate" | "plate_side"

module main() {
    plate_asmb_z = -bezel_d/2 - rear_tub_depth/2 + (tub_d/2 - 2 - plate_face_gap) + plate_t/2; // -11.0
    if (show_assembled) {
        // Assembled view
        if (show_front_bezel) front_bezel();
        if (show_rear_tub) {
            translate([0, 0, -bezel_d/2 - rear_tub_depth/2]) // Tub rim meets bezel back face
                rear_tub();
        }
        if (show_screen_plate) {
            translate([0, 0, plate_asmb_z])
                screen_mount_plate();
        }
        if (board_stack_visible) {
            // Board front face sits on the bezel lip back (z=+3): slab at z=-2
            translate([0, 0, -2])
                board_stack_ref();
        }
        if (show_bracket) {
            // Bracket front face flush with the tub rear face (center at
            // tub rear - 2.5): tub rim at -5, rear at -30, bracket 5 thick.
            translate([0, 0, -bezel_d/2 - rear_tub_depth/2 - 10]) // was -7.5: bracket overlapped the wall 2.5mm
                bracket_mount();
        }
    } else if (export_part == "bezel") {
        front_bezel();
    } else if (export_part == "rear_tub") {
        rear_tub();
    } else if (export_part == "bracket") {
        bracket_mount();
    } else if (export_part == "screen_plate") {
        screen_mount_plate();
    } else if (export_part == "plate_side") {
        plate_side();
    } else if (show_stack) {
        // z-EXPLODED full-stack view (renders only): bezel / board / plate /
        // tub / bracket, spread along z so every part reads.
        //   bezel +76 .. +81   board +29..+39  plate -1.5..+1.5
        //   tub  -88.5..-63.5  bracket -116.5..-111.5
        zs = 38;
        if (show_front_bezel)  translate([0, 0,  2*zs]) front_bezel();
        if (board_stack_visible) translate([0, 0,  zs - 2]) board_stack_ref();
        if (show_screen_plate) translate([0, 0,  0]) screen_mount_plate();
        if (show_rear_tub)     translate([0, 0, -2*zs]) rear_tub();
        if (show_bracket)      translate([0, 0, -3*zs]) bracket_mount();
    } else {
        // Exploded / individual parts for viewing
        if (show_front_bezel) {
            translate([0, 0, exploded * explode_z])
                front_bezel();
        }
        if (show_screen_plate) {
            translate([0, 0, plate_asmb_z - exploded * 15]) // drop it behind the bezel stack
                screen_mount_plate();
        }
        if (show_rear_tub) {
            translate([tub_w + 50, 0, exploded * explode_z]) // Offset to side
                rear_tub();
        }
        if (show_bracket) {
            translate([tub_w + 50, 100, exploded * explode_z])
                bracket_mount();
        }
    }
}

main();