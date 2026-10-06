# mograf teaser v2 — "Anatomy"

A 15.5 s, 1:1 (1080×1080), 30 fps teaser built with Claude Code, HyperFrames and GSAP. A finished motion piece explodes in z into its four layers (prompt, skills, source and copy), slams shut, and turns into the mograf mark.

![poster](poster.png)

## What's in the kit

| File | What it is |
|---|---|
| `prompt.md` | the prompt that started it, plus the skills that were loaded |
| `brief.md` | goal, format, brand and audio mode |
| `concept.md` | the one-line idea and the signature moment |
| `storyboard.md`, `beats.json`, `transitions.json` | beat-by-beat plan with times, eases and seams |
| `frame.md`, `styleframes/` | design spec and the three approved stills |
| `copy.md` | on-screen words and post copy |
| `index.html` | the composition: one paused GSAP timeline, seek-safe and deterministic |
| `audio-cues.md` | the SFX cue sheet (no audio files are shipped) |
| `ASSETS.md`, `NOTICE`, `LICENSES/` | where every file came from and under which license |

## Run it

Requires Node 22+, Chrome and FFmpeg (HyperFrames uses them for rendering).

```bash
npm install          # installs gsap (not vendored, see ASSETS.md)
npm run check        # lint + layout + contrast
npm run dev          # Studio preview
npm run render       # MP4 into renders/
```

The render is silent unless you add audio back from `audio-cues.md`.

## Notes

- If you change anything visible around 11.5–12.1 s, re-run `npm run capture-seam`. The crosswarp shader transitions between real captures of the composition.
- The impact shake is a hand-tuned table (`JOLT`), not the registry profile used in the original render. See `ASSETS.md`.
