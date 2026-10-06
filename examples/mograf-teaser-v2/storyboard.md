# Storyboard — mograf teaser v2 "Anatomy" (1:1, 1080×1080, 30 fps, 15.5 s)

**Rhythm:** `still-SNAP-slow ORBIT-tick-tick-tick-tick-SLAM-warp-HOLD`
Beat lengths: hook 2.70 · snap 0.36 (80% of the depth in the first 0.36 s of the EK arrival) · orbit/read 3.50 · ticks 4 × 1.10 · slam 0.18 · flatten 0.58 · warp 0.60 · mark home 0.47 · build 1.4 · still hold 1.50.
Slowest beat (orbit/read 3.5 s) ÷ fastest tick (1.1 s) = 3.2× ; tween spread 0.18 s (slam) → 2.5 s (camera) = 13.9×.
Primary seam: **cut-the-curve** (5 of 8 seams = 62%); accents: speed-ramp snap, smash-on-impact; **1 shader** (gl-transitions crosswarp) on real captures.

Ids: rules/blueprints from the HyperFrames `hyperframes-animation` skill indexes; move names are mograf house names; registry items = `npx hyperframes add …`.

| t (s) | Beat | On screen | Verb per element | Rule / blueprint ids | Ease token | Cut in → out | SFX cue |
|---|---|---|---|---|---|---|---|
| 0.00–2.70 | B1 hook — the piece | Full-bleed poster "arrival" (sun on horizon) + **One prompt made this.** | sun RISES 110→0 (motivated ambient, end pose); camera PULLS BACK z 0→−360, tilt 9° (the poster becomes an object); card corners round 0→22 | `zoom-out-workspace-reveal` (inverse of Linear tilt pose), move 11 *Camera on the Real Product*, move 18 *Dark Room Light* | mg.settle (sun), mg.travel (camera) | open: frame 0 composed, no fade → out: speed-ramp snap | riser (cut crest on 2.70) |
| 2.58–2.88 | hook exit | hook lines | EXIT by mask, down | `cut-the-curve` (type), transitions: exit = transition | mg.exit | cut-the-curve ↓ | (inside riser) |
| **2.70** | **B2 SIGNATURE — explode** | stack separates: piece / copy / source / skills / prompt | planes EXPLODE z 0→−170…−680 (EK arrival); camera FLIES to iso pose x200 y−300 z−1650 rX 52, in-plane spin 0→45° (the stack becomes diamonds = the mark); stage travel blur 3.5 px peak | rule `depth-scatter-assemble` (radial-explode), `3d-camera-flight`, move 13 *Exploded View*; registry `extended-keyframe` | EK.ease (planes), mg.settle (camera, spin) | speed-ramp snap (pull-back keeps velocity into the explode) | whoosh (lead 120 ms) |
| 2.85–3.35 | tag | ◆ anatomy of piece 027 | WIPES on from left margin | `discrete-text-sequence` | mg.enter | — | silence |
| 2.95–6.20 | B2 read | **Every piece ships with / what made it.** | LANDS line-masked, 6 px approach blur → sharp, line stagger 90 ms eased; holds 2.6 s | type-choreography LANDS, move 21 *Blur-In Type* | mg.enter | cut-the-curve ↑ at 6.20 | silence |
| 4.20–5.80 | light event 1 | warm specular band across the top plane | SHINES once | move 19 *Light-Sweep Reveal*, registry `light-sweep-pass` (recipe) | mg.inout | — | silence |
| 5.60–6.50 | camera reposition | — | camera TRAVELS x200→265 (makes room bottom-left for the rack, end pose) | `multi-phase-camera` | mg.travel | — | silence |
| 6.20 / 7.30 / 8.40 / 9.50 | B3 rack ticks | **prompt** / **skills** / **source** / **copy** + one persistent index `0k / 04` (digit rolls 0.12 out / 0.30 in) | word SWAPS (exit 0.22 power3.in, entry 0.51 expo.out, velocity-matched); deck OPENS at layer k: every layer above it RISES +380 z (a wave travelling up the stack); DOF RACKS to layer k (others blur 5 px, 0.55 brightness) | `depth-of-field-blur`, `fixed-anchor-cycle`, move 14 *Contact Chain*; registry `motion-blur` (rack words), `focus-rack` (recipe) | expo.out / power3.in (swap), mg.ui (deck), mg.settle (DOF) | cut-the-curve ↑ ×4 | click-soft ×4 (−14 dB) |
| 10.26–10.60 | deck closes / tag exits | — | layers RETURN; tag wipes off | — | mg.exit | — | silence |
| 10.60–10.90 | **B4 SLAM** | stack | anticipation: layers breathe out ×1.1 (0.12 s), then SLAM shut (0.18 s, accelerating into contact) | move 16 *Break Physics Once* (anticipation), `kinetic-beat-slam` (physics) | mg.ui → mg.exit | smash on impact | **suck-in 10.60–10.85** (room tone only), impact-bass-1 (faded) on 10.90 |
| 10.90–11.10 | impact | whole world | SHAKES 6 frames, translation only | inline `JOLT` table (hand-tuned px offsets, rotation off) | jolt | — | (impact) |
| 10.95–11.53 | flatten | the closed stack | camera LANDS top-down: rX 52→0 — the stack is a **diamond**; stage travel blur 0→2.5→0 px | `3d-camera-flight` (tilt-to-flatten) | mg.travel (ends moving → cut at peak velocity) | → shader | whoosh-cinematic swell starts |
| **11.53–12.13** | SHADER seam (shape match) | the piece-diamond warps into a clay diamond of the same size and place | crosswarp progress | gl-transitions `crosswarp` (MIT) on real captures (`scripts/capture-seam.sh`) | mg.settle (fast start = velocity carried from flatten) | shader | whoosh-cinematic peak on 12.13 |
| 12.13–12.60 | B5 mark home | clay diamond ×7.67 → ◆ | TRAVELS to the lockup slot, motion-blurred | `logo-assemble-lockup`, registry `motion-blur` | mg.settle | — | (swell tail) |
| 12.60–13.30 | B5 lock | ◆ + 4 echo diamonds | echoes DROP 0→18·n (the stack remembered under the mark) | `logo-assemble-lockup` (assemble-from-parts) | mg.ui | — | (swell tail) |
| 12.65–13.60 | wordmark | **mograf** | WIPES out of the mark + weight FLEXES wght 120→500 | type-choreography FLEXES; registry `variable-font-flex` (recipe) | mg.settle | — | click-soft −12 dB |
| 12.85–13.47 | tagline | **Motion graphics, one prompt away.** | LANDS line mask + 6 px approach blur | move 21 | mg.enter | — | silence |
| 13.10–13.75 | url / meta | — mograf.si · prompt · skills · source · copy | rule GROWS, text WIPES | — | mg.ui / mg.enter | — | silence |
| 13.10–14.00 | light event 2 | gloss band clipped to the wordmark glyphs | SHINES once | move 19 | mg.inout | — | silence |
| **14.00–15.50** | final still hold | lockup (thumbnail) | nothing moves except grain | — | — | end | sound tail decays |

## Finishing stack (architecture §4) — where each item lives
| Layer | Item | Where |
|---|---|---|
| Background life | room radial + clay key light (0.2× parallax with the camera) | whole piece |
| Depth | perspective 1700 px stage → preserve-3d world → in-plane spin → 5 planes; DOF on leaf planes | 0.2–11.2 s |
| Hero arrival | `extended-keyframe` EK.ease on the explode | 2.70 |
| Speed | registry `motion-blur` (720°, 12 samples) on the 4 rack words and the travelling mark; stage travel blur on the snap and the flatten | 2.70, 6.2–10.6, 10.95, 12.13 |
| Impacts | inline `JOLT` (hand-tuned) | 10.90 |
| Light | two sweeps (stack plane, wordmark glyph gloss) | 4.2, 13.1 |
| Seams | cut-the-curve ×5, speed-ramp, smash, 1 shader | — |
| Texture | `grain-overlay` (0.07, overlay, offset reseeded 12×/s from the timeline) | always |
| Frame | `vignette` (corner alpha 0.42) | always |

## 16:9 variant (planned, not rendered)
1920×1080, same timeline. Re-layout: stage perspective 1900 px; the stack moves to the right two thirds (world x +420 at the iso pose) and the type column widens to 760 px on the left 6/12 columns with title-safe 96 px margins; hook 120 px, rack words 230 px; lockup becomes one row (mark + wordmark left, tagline right-aligned under the wordmark baseline, url bottom-left, meta bottom-right). The flatten lands the diamond center-right; the shader is unchanged (re-capture at 1920×1080 with `capture-seam.sh`).

## Polish history
- Loop 1 (review POLISH, 4 gates): shake moved to translation-only ×0.8 (no 500 px throw); shader now lands on a clay diamond matching the flattened stack, then the mark travels home with motion blur; rack ticks 1.0 → 1.1 s; one persistent rack index with a rolling digit; echoes `mg.ui`; lockup sweep replaced by a glyph-clipped gloss; room tone + re-levelled SFX; GSAP license exception; flatten blur; stack x 320 → 265 so it stays inside the canvas; runtime 15.0 → 15.5 s.
