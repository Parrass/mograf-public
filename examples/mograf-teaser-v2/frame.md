---
name: mograf-teaser-v2
canvas: { width: 1080, height: 1080, fps: 30, aspect: "1:1" }
colors:
  bg: "#141413"          # slate ground (never flat: radial room light + grain)
  ink: "#FAF9F5"         # ivory
  accent: "#D97757"      # clay — sun, mark, indices, one italic phrase; ≤ 10% of frame
  surface: "#1F1E1D"     # plane glass / piece ground
  support: ["#262624", "#3D3D3A", "#9C9A92"]
  code-comment: "#8E8B83" # passes 3:1 at 34 px on #1F1E1D (check contrast)
typography:
  display:
    family: "Instrument Serif"
    files: ["fonts/InstrumentSerif-Regular.ttf", "fonts/InstrumentSerif-Italic.ttf"]
    license: OFL-1.1 (LICENSES/OFL-InstrumentSerif.txt)
    roles:
      hook:     { size: 104, lineHeight: 1.0, tracking: -0.03em }
      line2:    { size: 92, lineHeight: 1.02, tracking: -0.03em, emphasis: "italic + clay on 'what made it.'" }
      rackWord: { size: 210, style: italic, tracking: -0.035em }
      tagline:  { size: 76, lineHeight: 1.06, tracking: -0.025em, emphasis: "italic on 'one prompt away.'" }
      piece:    { size: 250, style: italic, tracking: -0.035em }   # the dissected piece's own word
    contrast: "size + italic (family ships 400 only) — scale ratio 210:24 ≈ 8.8:1"
  mono:
    family: "JetBrains Mono"
    file: fonts/JetBrainsMono-VF.ttf
    axes: { wght: [100, 800] }
    license: OFL-1.1 (LICENSES/OFL-JetBrainsMono.txt)
    roles:
      wordmark: { size: 168, wght: 500 (rest), tracking: -0.045em, choreography: "wght 120 → 500 flex on lock" }
      labels:   { size: 22-30, wght: 400/700, tracking: 0.04–0.08em, color: "#9C9A92", index in clay 700 }
      code:     { size: 34, lineHeight: 1.6 }
  banned_check: "no Inter/Roboto/Poppins/Playfair/EB Garamond/Bodoni Moda/Syne/Fraunces"
grid:
  columns: 6
  margin: 65          # 6% of 1080
  gutter: 24
  anchors: "type anchored to the left margin (x=65); the object lives right/upper-right; lockup row on the left third"
safeArea: { box: "65,65 950×950", rule: "1:1 feed — 6% margin; no text outside" }
layers:
  - room (0.2×): radial base #1B1A19→#141413→#0F0F0E + clay key light radial (16% → 0) that slides with the camera
  - world (1.0×): perspective 1700 px stage → preserve-3d #world (camera) → #spin (in-plane 45°) → 5 planes (prompt, skills, source, copy, piece) at z = −680/−510/−340/−170/0
  - type (screen space): hook, tag, line2, rack word + index, lockup
  - finishing: vignette (radial, 0 → 0.42 alpha at the corners ≈ strength 0.25), grain-overlay (fractal noise, overlay blend, opacity 0.07, offset stepped at 12 fps from the timeline)
texture: { grain: 0.07, vignette: 0.25, background: "radial gradients only — no linear gradients on the dark ground" }
easing:
  mg.enter:  "B2 sentence line masks, rack word entries, tagline"
  mg.settle: "hero arrival creep of the explode, DOF racks, wordmark flex landing"
  mg.travel: "camera legs (pull-back, orbit into the iso pose)"
  mg.exit:   "slam (planes accelerate into contact), hook exit"
  mg.cut:    "rack-word swaps cut at peak velocity"
  mg.inout:  "light sweep across the lockup, shader progress"
  mg.ui:     "plane pull-out micro moves during racks"
  springEase: "the single overshoot of the piece — the clay mark lock (ζ 0.82, ≈1.5%)"
  extended-keyframe: "EK.ease() on the explode's world arrival (80% of the move in the first 20%, then creep)"
---

# Frame — "Anatomy"

**The frame in one paragraph.** A dark room lit by one warm clay key from the upper left. In it, a finished motion piece ("arrival": a clay sun clearing a hairline horizon under one italic serif word) is first seen full-bleed as if it were just another feed post, then revealed as a physical object: it explodes along its normal into four thin glass planes — prompt, skills, source, copy — seen from an isometric camera (rotationX 52°, in-plane 45°), so the stack reads as a fan of diamonds. The diamond is the mograf mark; the stack *is* the logo seen from the side, which is why the film can slam the layers shut and land on the mark. Type is screen-space and anchored to the left margin, the object lives upper-right; nothing floats in the center.

**Composition rules.**
- One lead at a time: object OR sentence leads; the other holds still.
- Type sits bottom-left (hook, line2, rack word) or on the left third (lockup). The object owns the upper-right 70%.
- The only clay: the sun, the mark, plane indices, the rack index, one italic phrase per beat. Measured ≤ 9% of frame area at the open (sun), ≤ 3% elsewhere.
- Plane labels live on each plane's bottom-left edge, the edge that stays visible in the iso stack.
- Planes are glass `rgba(31,30,29,.94)`, 2 px hairline `rgba(250,249,245,.12)`, 22 px radius, deep shadow `0 60px 140px -30px rgba(0,0,0,.85)` (Linear dark-room recipe).

**Forbidden.** Flat `#000`; linear gradients on the ground; center-stacked title/subtitle/button; glass blur stacks (planes are opaque glass, no backdrop-filter); emoji/icons; neon glow; a second accent hue; text over the clay sun.

## Styleframes (rendered from the composition at rest poses)

| Still | Time | File | What it proves |
|---|---|---|---|
| open | 0.00 s | `styleframes/open.png` | Frame 0 is composed and readable muted: the piece full-bleed + hook |
| hero | 4.60 s | `styleframes/hero.png` | Signature pose: exploded iso stack + line 2 |
| close | 14.00 s | `styleframes/close.png` | Thumbnail-grade lockup with the mark's echo layers |

Safe-area versions: `styleframes/*.safe.png` (magenta box 65,65 950×950). Contrast report: `styleframes/contrast/`.

## Review (self-score, rubric §2 Composition / §3 Typography)

**Hero (4.6 s) — Composition 4/5.** Three depth layers (room light 0.2×, the stack with five internal z planes, screen-space type), two focal points (the clay sun on the top plane, the italic clay phrase bottom-left), the object fills ~72% of the width, scale contrast 92 px sentence vs 24 px tag ≈ 3.8:1 *within type* and object-to-label > 20:1, ~40% negative space (upper-left and left). Anchored: tag to the top-left margin, sentence to the bottom-left margin. Weakness: the stack's lowest plane tucks behind "with" — deliberate foreground/background layering, kept because it sells depth; the sentence keeps ≥ 7:1 contrast on the plane glass.

**Open (0 s) — Composition 4/5.** Reads as a finished poster: italic word left, sun right on a hairline horizon, meta corners, hook bottom-left on the dark lower half. Clay area ≈ 8.7%.

**Close — Composition 4/5, Typography 4/5.** Asymmetric left-anchored lockup, wordmark 168 px vs meta 22 px (7.6:1), mark with four hairline echo diamonds (the stack remembered), url bottom-left with a clay rule, meta bottom-right. Weakness: upper third is empty by design (light lives there; the light sweep crosses it in motion).

Fixes applied during styleframing: plane labels moved from top-left to bottom-left edge (they were hidden under the next plane); camera pulled from z −1250 to −1650 and lifted so the stack clears the sentence; the top-right "ghost stack" in the lockup was replaced by echo diamonds under the mark (it read as an unrelated widget).
