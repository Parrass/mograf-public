---
name: motion-review
description: Independent critic and quality gate for motion graphics. Scores a HyperFrames / GSAP / HTML (or Remotion) piece on a 9-dimension studio rubric, checks hard gates, a 12-point craft bar and the anti-slop list by actually looking at frames, then returns APPROVE / POLISH / REWORK with exact, frame-level fixes. Use before any render meant for delivery, after every revision, and whenever asked to review, critique, "make it better" or "is this good?". Best run as a fresh-context sub-agent so the builder never grades its own work.
license: MIT
---

# motion-review: the taste gate

Linters catch broken code. This skill catches **taste**. Default posture: *flag first; approval is earned.* A piece that "looks fine" scores 3, and 3 does not ship.

## How to run it

- Run as a **fresh sub-agent** when you can. Give it: this file, the project folder, and the brief. Do not tell it how hard the build was.
- The reviewer **never edits the composition**. It writes `review.md` in the project folder and returns the verdict.
- Look at pixels, not just code. Every score must point at a timestamp, frame or selector.
- **One reviewer per piece.** Two reviewers running at once write the same `review.md` and their verdicts conflict. Each round ends with one `verdict:` line; the caller polls `review.md` for it. Re-reviews go to the same reviewer; start a replacement only if `review.md` shows no new round after a long wait, note the cancellation in `review.md`, and have the replacement read the history first. If rounds conflict, the last write to `review.md` is authoritative.

## Procedure

Run every step. Commands assume a HyperFrames project (`npx hyperframes …`); for other stacks use the equivalent (Remotion: `npx remotion still` for frames, `npx remotion render` for the strip).

1. **Structure.** `npx hyperframes check .` Any error is a Block. Read the warnings too. Its contrast audit is the contrast gate. Decorative text never meant to be read (blur ghosts, ghost-trail clones, dissolving chips, scramble filler) is excluded with `data-layout-ignore` on each node; never use it to hide real copy.
2. **Motion map.** Read the timeline code (or the animation map, if your HyperFrames skills ship `animation-map.mjs`). Note:
   - dead zones of 1 s or more with nothing moving;
   - spatial moves shorter than 0.2 s (too fast to read) or longer than 2 s (drifting);
   - irregular or mechanical staggers;
   - elements that leave the frame or collide by accident.

   Motion driven through a proxy/setter object (custom camera, three.js, counters) is invisible to tween-based maps; use frame strips (step 5) for those moves.
3. **Contact sheet.** From the storyboard or beat list, take scene and seam times. Snapshot:
   - frame 0, the hero moment, and the final frame;
   - 25 / 50 / 75 % of every scene;
   - every seam at −2 frames, 0 and +2 frames.

   `npx hyperframes snapshot --at <t1,t2,…>`. Pass exact frame times (`t = frame / fps`, e.g. frame 316 at 30 fps → `10.5333`); `--at` does not snap, so a rounded time shows an in-between pose the render never contains. `snapshot` leaves stale PNGs from earlier runs, so move the old `snapshots/` dir aside before each run (e.g. `node -e "require('fs').renameSync('snapshots','snapshots-'+Date.now())"`) rather than deleting with an `rm` glob; `--at` can also add a stray frame you didn't ask for, so ignore extras. Open the images and **look**. Zoom on type only at times the element is visible (zooming on a hidden element can hang).
4. **Depth proof.** For camera or hero moves, `npx hyperframes keyframes --ghost --angle`. Planes separating along z mean real depth; everything scaling together means fake depth. Even ghost spacing on a hero move means linear easing, which fails. If `--ghost` cannot run, take a scratch copy and give the world's parent a proof camera (push back + pitch + yaw, e.g. `translateZ(-900px) rotateX(-28deg) rotateY(64deg)`; yaw alone puts the camera inside deep scenes), snapshot 4–6 frame times across the move and overlay them (`ffmpeg … -filter_complex blend=all_mode=lighten`). Build this onion by hand for nested perspective (`snapshot --angle side` flattens it) and for JS projection cameras (3D projected onto one SVG/canvas): swap a side camera into the projection function in the scratch copy.
5. **Real-speed watch.** If a render exists:
   - make a strip: `ffmpeg -i renders/video.mp4 -vf fps=6,scale=360:-1,tile=6x4 strip.jpg`;
   - check duration and the first and last frames with `ffprobe`;
   - if there is audio, check each hit against the cue sheet (±1 frame) and true peak ≤ −1 dBTP on the final AAC file (`ffmpeg -i … -af ebur128=peak=true -f null -`);
   - transparent `.webm` overlays: `ffprobe` shows VP9-alpha as `yuv420p`; verify alpha by decoding with `-c:v libvpx-vp9` before `-i` (stream reads `yuva420p`) or the `ALPHA_MODE=1` tag.
6. **Code read.** Grep the composition for:
   - `ease:` (list every ease used) and durations;
   - opacity-only entrances and small `y:` offsets (20–40 px);
   - `Math.random` / `Date.now` (non-deterministic);
   - `back.out|elastic|bounce`, `yoyo`, `repeat: -1`;
   - linear or `power1` on spatial moves; eases outside the allowed list (`mg.*`, `power3.out`, `expo.out`, `power3.in`, `power4.out`, `power2.inOut`, `none`, a baked spring);
   - concurrent tweens sharing an ease (fine only as a locked group: one multi-target tween or a child timeline with `defaults`; a setter-driven proxy counts once, by the ease on its tween);
   - a blurred line-mask rise starting below `yPercent 130` (blur leaks into the mask);
   - banned fonts;
   - missing grain, vignette or motion blur.
7. **Score** the 9 dimensions (anchors below), 1–5, each with a one-line reason tied to a time or frame.
8. **Craft bar** (12 items, pass/fail; table below).
9. **Anti-slop scan** (top-15 list below). Record ids.
10. **Licenses.** Every non-original asset (font, SFX, music, image, third-party code) has a source and a compatible license written down. Fonts: OFL or similar. Code: MIT or Apache with headers kept. Anything unknown: flag it.

## Rubric anchors (score 1–5)

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| **Concept** | No idea; text on backgrounds; any brand could be swapped in | Clear one-line idea; motion supports it in some scenes | One strong idea end to end with a surprising, ownable moment you can describe in a sentence |
| **Composition** | Everything centered, uniform sizes, clutter or empty without intent | Grid, one hero per frame, decent negative space | Every still is poster-grade: deliberate crops, depth layers, negative space; layouts evolve |
| **Typography** | System or generic font, default tracking, whole blocks fading | Right split unit (line/word/char), masked reveals, legible | Type *is* the animation: variable axes, kinetic layout, crop/scale play, flawless rhythm |
| **Timing & easing** | Linear or default eases, uniform durations, no holds | Custom eases on hero moves, durations vary, holds readable | Asymmetric velocity, tasteful overshoot, holds that feel inevitable frame by frame |
| **Choreography** | Everything moves together or in a uniform stagger | Hero leads, supports follow with offsets, overlap present | Conducted: one gesture flows into the next, secondary motion reacts to primary |
| **Transitions** | Crossfades or unrelated cuts | Designed masks/wipes, on beat | One continuous camera/idea; memorable, never gratuitous |
| **Depth & texture** | Flat vectors on a flat or blob gradient, static frame | Camera drift/push, 2+ depth planes, some grain or light | Real 3D or convincing 2.5D, lighting tells the story, texture unifies without showing off |
| **Sound sync** | Silent or unrelated audio | Major cuts land on beats | Picture and sound composed together; silence used as an accent; clean mix |
| **Finish** | Bugs, jitter, pops, aliasing, unloaded assets | Clean, consistent, designed end frame | Studio-deliverable; every frame scrutinized; end frame held and resolved |

Scores 2 and 4 sit between the anchors. To score **4**:

- **Timing:** ease palette by role, "fast out, long settle" arrivals, accelerating exits.
- **Choreography:** anticipation, follow-through and eased or distance-based staggers.
- **Transitions:** at least one match cut or morph, and cuts at peak velocity with blur.
- **Depth:** 3-plane parallax and motion blur on fast moves.
- **Composition:** at least 5× scale contrast.

A muted, SFX-free piece that declares itself silent in the brief scores Sound sync on its silences and visual rhythm; do not punish a deliberate choice.

## Hard gates (any one = Block)

- `check` fails, the render is non-deterministic, or a seek shows a glitch.
- Text you can't read:
  - hold shorter than 0.5 s + 0.3 s per word;
  - contrast below 4.5:1;
  - text crossing the safe area.
- Font flash, missing asset, broken or empty frame at a seam, or a pop on the first or last frame.
- 3 or more anti-slop hits without a written justification.
- Linear or default ease on a hero spatial move.
- A craft-bar item missing without a written waiver in the brief.
- More than 3 flashes per second.
- A third-party asset with no source or license on record.

## Craft bar (12 items)

1. **Concept.** A one-sentence idea, and a signature moment by ~40 % of the runtime.
2. **Hero still.** A designed hero frame (Composition ≥ 4, at least 3 depth layers).
3. **Camera.** At least one real camera or depth move, proven by the ghost or side-angle check.
4. **Custom eases.** At least 3 distinct ease characters, and no two concurrent tweens sharing one by accident.
5. **No default fade-up.** No `opacity 0→1` + `y 20–40→0` anywhere.
6. **Named seams.** Seams are named and velocity-matched; at most one plain crossfade.
7. **Motion blur** on 1–3 fast beats (never on text while it is being read).
8. **Texture pass.** Grain, vignette and radial (light-motivated) gradients.
9. **Light event.** At least one: a sweep, gloss, scan band, bloom or leak.
10. **Sound.** Sound sync if there is audio; otherwise the piece is declared silent.
11. **Rhythm.**
    - The slowest storyboard beat is at least 3× the fastest (beats are storyboard rows, not sub-tweens).
    - Across all tweens, max/min duration is at least 4.
    - The final still holds for at least 0.8 s.
    - The last frame works as a thumbnail.
12. **Rubric bar** met (see Ship bar).

## Anti-slop top 15

| id | Tell | Fix |
|---|---|---|
| S1 | Every element fades in and slides up 20–40 px | Entrance by role: masks/splits for text, scale-from-point for shapes, camera-carried for scenes |
| S2 | Identical durations (all 0.5 s / 1 s) | Duration from distance and mass; hero arrivals 0.8–1.5 s, exits ~30 % faster |
| S3 | Default ease (`power1`, CSS `ease`, `ease-in-out`) or linear on spatial moves | Named custom eases; asymmetric "fast out, long settle" |
| S4 | Uniform 0.1 s stagger | Eased stagger from a meaningful origin (center, focal point, reading order) |
| S5 | Everything moves at once, same speed | One lead; supports follow 2–8 frames later with less amplitude |
| S6 | No holds: in, then straight out | Read hold ≥ 0.5 s + 0.3 s/word |
| S7 | Dead stops: arrives and freezes | Long settle, micro drift through the hold |
| S8 | Elastic/back/bounce on everything | At most one overshoot per piece, ≤ 6 %, on transforms only |
| S9 | Idle "breathing" pulses (scale/opacity yoyo) | Stillness, or one motivated ambient, or a camera drift with an end pose |
| S10 | Fast moves with no motion blur | Shutter-style or directional blur on the 1–3 fastest beats |
| S11 | Centered stack: title / subtitle / button | Asymmetric grid, edge-anchored type, 30–50 % negative space |
| S12 | Static frame, no camera | Push, drift, parallax planes, punch-ins on beats |
| S13 | "Slides": scene fades out, next fades in | Motivated seams: match cut, momentum, mask, morph |
| S14 | Purple-blue / pink-orange blobs, glassmorphism, neon on everything | Gradients that behave like light from a source; 2–3 hues + neutrals, accent ≤ 10 % |
| S15 | Inter/Roboto/Poppins regular as "the design"; emoji or stock icons | Expressive display face, tight tracking, weight contrast; custom marks or none |

Also watch for:

- typewriter + cursor as the whole idea;
- generic counting numbers;
- lorem-like copy ("unlock the future of…");
- an ending that just stops or fades out;
- a flat energy curve with no climax;
- motion that would fit any message.

## Ship bar

- **APPROVE:** average ≥ 4.0, no dimension below 3, zero hard gates.
- **POLISH:** average 3.5–3.9, or one dimension at 3. Fix list, then re-review.
- **REWORK:** average below 3.5. Go back to concept and styleframes; polishing won't save it.

## review.md format

```
piece: <name> · reviewed: <date> · render: <path or none>
concept: N — …            composition: N — …        typography: N — …
timing_easing: N — …      choreography: N — …       transitions: N — …
depth_texture: N — …      sound_sync: N — …         finish: N — …
average: N.N
hard_gates: [ … ]
craft_bar: [1 ✓, 2 ✗ (reason), …]
anti_slop_hits: [S1, S7, …]
verdict: APPROVE | POLISH | REWORK   → route fixes to: concept | composition | motion build
contact_sheet: <path>
```

Then a **Before | After | Why** table. Order it by leverage (impact ÷ effort), and make every "After" an exact value:

| # | Where (t / frame / selector) | Before | After | Why |
|---|---|---|---|---|
| 1 | 3.40–3.90 s `#title` | opacity + y 30, `power2.out` 0.5 s | split into lines, mask reveal, settle ease `cubic-bezier(0,.65,.51,.99)` 0.9 s, lines +4 frames | default fade-up (S1); no settle (S7) |

Fix order: **delete → reduce → fix easing → fix composition/origin → retime → add depth/blur/texture → polish.** Never write "make it more dynamic"; always give a recipe with numbers.

## Re-review

Re-reviews go back to the same reviewer. After fixes, re-run step 1, step 3 (changed regions and their seams) and step 7. Any retime re-runs `check`: its contrast samples move with the timing. Keep the old scores in `review.md` so the improvement is visible, and end each round with its own `verdict:` line. Stop after 3 polish loops; if the average is still below 4.0, return REWORK.

---

Part of the free mograf skills (MIT). For the full studio pipeline, see [mograf.si](https://mograf.si). Each piece in the library ships with its prompt, skills, source and copy.
