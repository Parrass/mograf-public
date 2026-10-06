---
name: motion-craft-lite
description: Free subset of the mograf motion doctrine. Load it before writing or editing any animation code (HyperFrames, GSAP, CSS, Remotion, Three.js, Lottie) or any motion graphic. It covers named ease tokens, video duration bands, choreography rules and a "never do" list that removes the most common template/AI-slop motion. Use whenever asked to animate, add motion, make a video, or make motion feel less generic.
license: MIT
---

# motion-craft-lite

These are house rules for motion that looks designed, not templated. If an upstream skill or library default disagrees on easing, timing or choreography, follow this file.

## 0. The one test

Before writing any tween, ask *what does this movement mean?* If the answer is "it makes the thing appear", stop. Motion should carry the idea (squeeze, pour, break, stack, assemble, push through) or lead the eye to the next thing that matters.

## 1. Ease tokens

Register these once per composition and use them by role:

```js
gsap.registerPlugin(CustomEase);
CustomEase.create("mg.enter",  ".20,.75,.34,.94"); // entrances: sharp in, clean landing
CustomEase.create("mg.settle", ".00,.65,.51,.99"); // landings, lockups, count-ups: fast out, LONG settle
CustomEase.create("mg.travel", "1,.49,0,.55");     // long A→B travel (S-curve, steep midpoint)
CustomEase.create("mg.depart", ".33,0,.12,1");     // camera/element leaving FROM REST
CustomEase.create("mg.exit",   "1,.02,.54,.42");   // exits: accelerate away
CustomEase.create("mg.cut",    ".15,.85,.95,.05"); // moves interrupted by a cut, never settle
CustomEase.create("mg.ui",     ".23,1,.32,1");     // UI-in-video micro moves
CustomEase.create("mg.inout",  ".77,0,.175,1");    // on-screen morphs and reframes
```

The same curves as CSS `cubic-bezier(...)` work in CSS and WAAPI. In Remotion, use `Easing.bezier(...)`.

Two traps:
- `mg.settle` starts with a vertical tangent: on a rotation or camera move that starts **from rest** (after a click, after a hold) it jolts in one frame. Use `mg.depart` there.
- `mg.travel` is **S-shaped with a near-vertical midpoint tangent**, not near-linear: it barely moves at the ends and jumps in the middle (on a 0.75 s camera move, 28 % of the travel lands in one frame). Keep it for long travel (≥ ~1.2 s); for short camera moves use `mg.inout` or a baked spring, and `mg.depart` when leaving from rest.

This is the whole allowed list: the `mg.*` tokens plus these built-ins (and a baked spring at damping 0.80–0.85 if you need one). Anything else (`power2.out`, `sine.*`, `power4.in`, …) is off-palette:

- `power3.out`: the workhorse.
- `expo.out`: entries on a cut.
- `power3.in`: exits into a cut.
- `power4.out`: hard camera / hero landings.
- `power2.inOut`: camera repositioning.
- `none`: only for loops, marquees, mechanical motion and constant-speed path travel.

Rules:
- A piece uses at least 3 ease characters. Two tweens running at the same time in a scene don't share an ease unless they move as one **locked group**: one tween with several targets, or a child timeline with `defaults`, counts as one ease user.
  ```js
  tl.fromTo([".card", ".card-label"], { y: 60 }, { y: 0, duration: 0.7, ease: "mg.settle" }, T); // one group
  const lockup = gsap.timeline({ defaults: { ease: "mg.enter", duration: 0.6 } });           // one group
  lockup.fromTo(".logo", { scale: 0.94 }, { scale: 1 }, 0).fromTo(".wordmark", { xPercent: -8 }, { xPercent: 0 }, 0.08);
  tl.add(lockup, T + 0.3);
  tl.fromTo(".kicker", { yPercent: 105 }, { yPercent: 0, duration: 0.5, ease: "mg.depart" }, T + 0.3); // concurrent → own ease
  ```
- Count ease *users*, not tweens. A locked group counts once. A setter-driven proxy (one tween on a `{t}` or camera object whose setters repaint the scene) counts as one user with the ease on its tween; eases evaluated inside its paint function don't count separately, so many simultaneous contacts can run from one driver. Concurrent drivers still need different eases.
- Swapping an ease while polishing can create a new collision. After every swap, re-check which tweens overlap in time and what they use.
- Stagger distribution eases (`stagger: { each, ease }`) are timing offsets, not tween eases; they don't count.
- Hero spatial moves never use linear, `power1`, CSS `ease` or `ease-in-out`.
- Overshoot is opt-in: at most one per piece, at most 6 %, on transforms only. `back.out`, `elastic` and `bounce` are out unless the brief asks for a playful register.

## 2. Durations (video, not UI)

| Thing | Duration |
|---|---|
| Micro (tick, icon state) | 0.15–0.3 s |
| Element enter | 0.4–0.8 s |
| Hero arrival | 0.8–1.5 s, then hold |
| Exit | ~30 % faster than its entrance (0.25–0.5 s) |
| Camera move | 1.0–2.5 s, one per scene, calmer than the objects |
| Hard cut / beat hit | 0 s (`tl.set`); easing a hit kills it |
| Read hold | ≥ 0.5 s + 0.3 s × words |
| Final logo / CTA hold | ≥ 0.8 s, perfectly still, works as a thumbnail |

- **Rhythm.**
  - The slowest storyboard beat is at least 3× the fastest (a beat is a storyboard row, not a sub-tween inside it).
  - Across all tweens, longest ÷ shortest should be at least 4.
  - Name the rhythm before you build, e.g. `fast-fast-SLOW-cut-hold`.
- **Distance and mass.** Longer distance or more mass means a longer duration.
- **Opening.** The first move starts at 0.1–0.3 s and the hero is visible by 0.5 s.
- **Social.** Frame 0 is already composed and readable. Never fade up from black.

## 3. Choreography

1. **One lead at a time.** At every moment the eye has exactly one thing to follow.
2. **Lead / follow offsets.** Supports lag the lead by 2–8 frames (compact) or 4–14 frames (expressive), with less amplitude.
3. **Contact chain.** The next element starts when the previous one arrives at or touches it, not on an arbitrary timer.
4. **Opacity is subordinate.** It starts after movement starts and finishes before the settle. Opacity alone is never the entrance.
5. **Stagger.** 50–120 ms per item, eased or from a meaningful origin (center, focal point, reading order). The whole stagger lasts 0.6 s or less.
6. **Reveal across the back half.** Don't front-load a scene. The last 50 % should still be adding information.
7. **Build → settle → hold.** Every move ends on a hold. Motion without rest is noise.
8. **Exits are simpler and faster than entrances.** Inside a sequence, the transition *is* the exit.
9. **Direction has meaning.** Forward/next goes left or up; back/dismiss goes right or down. Keep it consistent.

## 4. Never do this

- **The default fade-up.** `opacity 0→1, y 20–40→0, power2.out` on anything. Text uses masks, splits, depth, cuts or a light pass instead. A line-mask rise (`yPercent → 0` inside an overflow-hidden line) that also blurs on the approach starts at `yPercent ≥ 130`; at 105 the blur halo leaks into the mask before the line moves. Hide masked lines at build time with `gsap.set`, not a `tl.set(…, 0)` (which can fool contrast audits into sampling the unhidden line).
- **`scale(0)` entrances.** Exceptions: dots, particles and mask circles. Otherwise start at 0.9–0.97.
- **Uniform timing.** Identical durations, or a uniform 0.1 s stagger.
- **Idle breathing.** Scale or opacity yoyo pulses on idle elements. Instead, use stillness, one motivated ambient background, or a camera drift that has an end pose.
- **Scene "slides".** Fade out, then fade in.
- **Flat `#000` or linear gradients on dark backgrounds.** H.264 bands them. Use radial gradients and a little grain.
- **Cheap decoration.** Emoji, stock icons, drifting gradient blobs, stacked glassmorphism, neon on everything, rainbow palettes. Use 2–3 hues plus neutrals, with the accent on 10 % of the frame or less.
- **Monoculture fonts as the design.** Inter, Roboto, Poppins, Playfair, EB Garamond, Bodoni Moda, Syne, Fraunces. Pick an expressive OFL display face and set it tight (−0.02 to −0.05 em, line-height ~1.05), with weight contrast (300 vs 900).
- **Typewriter + blinking cursor as the main idea,** unless the piece is literally about typing or code.
- **An ending that just stops or fades out.** Design the last frame and hold it.

Self-check before you hand it over:

1. Can you state the idea in 15 words?
2. Would a random frame work as a poster?
3. Are there at least 3 easing personalities, used by role?
4. Is there one violent contrast of speed (very slow, then very fast)?
5. Does every transition have a motive?

## 5. Video basics

- **Type size at 1080p.** Headlines 64–120 px (90 px or more in a feed). Body text 32 px or more.
- **Hierarchy.** The hero fills 60–80 % of the width. Scale contrast is at least 5:1. Leave 30–50 % negative space (a centred logo or end-card frame may go up to 75 %), and anchor to a grid or the edges.
- **Safe areas.**
  - 16:9: keep text inside the 90 % title-safe area.
  - 9:16: no text in the top 14 %, bottom 20 % or right 12 %.
  - 1:1 and 4:5: 6 % margin.
- **Frame rate.**
  - 30 fps is the social default; use 60 fps for UI demos and fast type.
  - Never mix frame rates in one piece.
  - A full-frame lateral pan without blur needs 5–7 s or it judders.
- **Determinism (HyperFrames / any frame renderer).**
  - One paused timeline. Use `fromTo` with absolute values.
  - Tween transforms, opacity, filter and clip-path only. No CSS transitions.
  - No `Math.random` or `Date.now`; use a seeded PRNG.
  - Load fonts from local `@font-face` files and split text only after `document.fonts.ready`.
  - Stacked `fromTo` tweens on the same property get `immediateRender: false` written literally in each vars object (linters look for the literal key, not a helper that adds it).
  - Computed transforms, canvas and three.js renders come from timeline time through a setter-driven proxy, not `onUpdate` (callbacks are suppressed on seek).

---

This is the free subset of the mograf doctrine (MIT). The paid library at [mograf.si](https://mograf.si) adds the director pipeline, the specialist skills (type, transitions, depth, sound) and the finishing stack. Every piece ships with its prompt, skills, source and copy. For a quality gate, pair this skill with the free `motion-review`.
