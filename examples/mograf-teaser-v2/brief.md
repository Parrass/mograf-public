---
workflow: general-video
flow: companion
storyboard: no
message: "Motion graphics, one prompt away."
destination: x.com feed (autoplay, muted)
aspect: "1:1"
resolution: 1080x1080
fps: 30
length: 15.5s
language: en
audience: designers, indie hackers and AI builders on X who use Claude Code
---

# Brief — mograf teaser v2

> Note: on Windows `brief.md` and HyperFrames' `BRIEF.md` are the same file (case-insensitive FS), so this one file carries both the HyperFrames routing frontmatter above and the mograf director brief below.

## Goal
A scroll-stopping brand teaser for **mograf** (mograf.si) that a designer on X watches twice. Viewer should feel: *this is studio work, and I can have the recipe.* Viewer should do: open mograf.si.

v1 (`library/mograf-teaser`, terminal → type → stat → bars → logo) was judged "too simple": flat, centered, one plane, a montage of demo widgets. v2 must carry one idea end to end with a real camera.

## Channel & format
- X feed, autoplay muted. **1:1, 1080×1080, 30 fps** (motion-craft §7: social default; the camera moves are long and carry motion blur, so 60 fps is not needed).
- 16:9 (1920×1080) variant is **planned** in `storyboard.md` (re-layout notes) but **not rendered** (scope).
- Duration **15.5 s** (brief range 12–18 s; retimed from 14.5 → 15.5 s in polish loop 1 to give each rack word ≥ 0.8 s of readable hold).

## Brand
- Palette: Slate `#141413` ground · Ivory `#FAF9F5` ink · Clay `#D97757` single accent (≤ 10% of frame) · warm grays `#1F1E1D #262624 #3D3D3A #9C9A92`.
- Wordmark: lowercase mono **mograf** with a clay diamond (rotated square) mark.
- Fonts (OFL, local `@font-face`, licenses in `LICENSES/`): **Instrument Serif** (display, roman + italic) + **JetBrains Mono** variable (labels, code, wordmark; `wght` 100–800 is the choreography axis). No banned families.
- Message: "Motion graphics, one prompt away." Product truth: a library of studio-grade motion pieces + Claude Code skills; **every piece ships with its prompt, skills, source and copy.**

## Audio mode
Muted-first: the piece must read with sound off. Sound design = **SFX only** from the media-use bundled library (Pixabay Content License; render-only, fine inside the rendered video, not redistributed in this repo). **No music bed**: no license-clean bed was sourced, so this is a declared SFX-only piece. Every cut, snap, slam and lock has a cue or a written silence (`sfx-plan.json`).

## Scope (exact)
Delivered: `renders/video.mp4` (1:1, 30 fps, `-q high`), `poster.png`, all pipeline files (brief, concept, copy, references, frame, styleframes, storyboard, beats.json, sfx-plan.json, transitions.json, assets.ledger.md, LICENSES/), `review.md`, `prompt.md`.
Not delivered (offered only): the 16:9 render, a 9:16 cut, a silent source pack with `audio-cues.json`.

## Constraints from the request
- Do not run `hyperframes preview` (overrides general-video §5.8 "open the Studio preview before render"). Final approval = the independent motion-review APPROVE.
- No Docker; local render on Windows (Chrome + FFmpeg present).

## Licensing in this public copy
GSAP is declared as an npm dependency (`package.json`), not vendored. The Pixabay SFX are not redistributed (see `audio-cues.md`); the composition ships silent. The registry camera-shake profile was replaced with a hand-tuned impact jolt. Full list: `ASSETS.md`.

## Craft-bar waivers
None requested. (If the independent review finds a gap, it is fixed, not waived.)
