# Third-party material

mograf's own work in this repo is MIT (see `LICENSE`). The files below are third-party. They keep their own licenses and are listed per file in `examples/mograf-teaser-v2/ASSETS.md` and `NOTICE`.

## Included in the repo

| Material | Where | License | What we did |
|---|---|---|---|
| HyperFrames registry code (`motion-blur`, `extended-keyframe` snippets; 7 component reference copies) | `examples/mograf-teaser-v2/vendor/hf-*.js`, `compositions/components/` | Apache-2.0 (heygen-com/hyperframes) | Kept unmodified with an attribution header. Full license text and a `NOTICE` ship next to them. Other registry recipes were re-implemented inline in `index.html` and marked. |
| gl-transitions `crosswarp` | `examples/mograf-teaser-v2/compositions/gl/` | MIT (Eke Péter / gl-transitions contributors) | Original header kept; MIT text in `LICENSES/MIT-gl-transitions.txt` |
| Instrument Serif | `examples/mograf-teaser-v2/fonts/` | SIL OFL 1.1 | Unmodified; license file included |
| JetBrains Mono (variable) | `examples/mograf-teaser-v2/fonts/` | SIL OFL 1.1 | Unmodified; license file included |

## Required but not included

| Material | Why it is not here | How to get it |
|---|---|---|
| GSAP 3.14.2 (`gsap`, `CustomEase`, `SplitText`) | The GreenSock Standard "No Charge" License is not OSI-approved, so we don't redistribute the files | `npm install` in the example (declared in `package.json`) |
| Sound effects used in the published render | Pixabay Content License files; we don't redistribute them as standalone files | Cue sheet: `examples/mograf-teaser-v2/audio-cues.md` |
| HyperFrames CLI | Runtime tool | `npx hyperframes` (Apache-2.0) |

## Deliberately removed

- **HyperFrames `camera-shake` profile.** Its numbers were measured from Unity Cinemachine noise presets. The licensing of those values is unclear to us, so the public example uses an original hand-tuned impact jolt instead.

## Referenced only (links in `awesome-claude-motion.md`)

Everything listed in `awesome-claude-motion.md` is a link with a one-line description in our own words. We copy no media, prompts or text from those posts. Each item belongs to its creator.

Licenses checked 2026-10-06. If you spot an error, open an issue and we'll fix it.
