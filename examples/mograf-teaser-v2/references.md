# References — mograf teaser v2 ("Anatomy")

Library search first: `library/` holds only v1 (`mograf-teaser`) — borrowed from it: palette, wordmark spec, and the lesson "a montage of widgets is not an idea". Techniques only; no assets, frames, logos or music are taken from any reference.

### 1. Apple keynote hardware intros — exploded view + light sweep — https://www.apple.com/apple-events/
Why it fits: the exploded view is the visual grammar of "here is what is inside"; we apply it to a motion graphic instead of a phone.
Borrow: layers separate along one axis with **geometric spacing** (we use z = 0 / −170 / −340 / −510 with a small y lift −24 px per layer, i.e. `d, 2d, 3d` + lift), camera rotates while they separate (**rotateY −18 → our −30°, rotateX 12 → our 10°**, 2.2 s → our 2.6 s orbit), **hold ≈ 1.2 s** per readable state, recombine on an ease-in (we make it a slam: `mg.exit`-style accelerate, 0.32 s, + impact). Light sweep: **105° band, transparent 40% → 0.55 → transparent 60%, 2.4 s `power2.inOut`** → our clay-tinted sweep across the wordmark, 1.4 s `mg.inout`.
Beat: B2 explode/orbit (2.70–5.40), B4 slam (9.90), B5 light sweep (12.05).
Don't take: SF Pro, device renders, the black `#000` void (we use slate radial light), Apple music.

### 2. Linear feature launch films — camera on the real product, dark-room light — https://linear.app/changelog
Why it fits: the "product" here is a real piece; the camera should move *on* it, never float cards around.
Borrow: the opening tilt pose `rotateX 18, scale .82, y 120 → flat, 1.8 s expo.out` inverted into our pull-back (the piece starts flat full-bleed and the camera *backs off and tilts* to reveal it is an object); **dark-room light: one radial key behind the subject at ~18% alpha, hairline border `0 0 0 1px rgba(255,255,255,.06)`, deep shadow `0 40px 120px -20px rgba(0,0,0,.8)`, grain 0.06 overlay stepped at 12 fps**.
Beat: B1 pull-back (0.30–2.62), all plane surfaces, texture pass.
Don't take: Linear UI, their purple, their wordmark.

### 3. Figma Config 2024 opener (Relay) — mono type scale contrast, labels as structure — https://www.figma.com/blog/config-2024-branding/
Why it fits: our planes need to read as *system parts* with indexes and labels, not as decoration.
Borrow: mono micro-labels with indices (`01 / prompt`) at ~1/8 the size of the hero type (our 22 px mono vs 176 px serif ⇒ 8:1 scale contrast), one accent color doing all the pointing.
Beat: B3 rack (plane labels), B5 lockup meta line.
Don't take: Config supergraphics, their color system, the activation-grid cascade.

### 4. Ordinary Folk × School of Motion "Join the Movement" — snappy custom curves, hits land on the beat — https://motionographer.com/2019/09/16/join-the-movement/
Why it fits: the four rack ticks and the slam are percussive; they need snap without cartoon overshoot.
Borrow: **tweens END on the hit** (`start = hit − duration`); strong anticipation into a fast move (our slam: planes pull back 30 px in 0.12 s, then accelerate 0.32 s into contact); the *one* overshoot of the piece goes on the diamond lock (springEase ζ 0.82, ≈ 1.5%).
Beat: B3 word swaps (5.50/6.60/7.70/8.80), B4 slam, B5 diamond lock.
Don't take: OF characters, the playful bounce register, their palette.

### 5. OpenAI brand film (Studio Dumbar/DEPT, 2025) — blur-in still statement type — https://studiodumbar.com/work/openai-brand-film
Why it fits: B2's long sentence must feel calm and premium while the world explodes behind it.
Borrow: **blur 8 → 0 px, y 8 → 0, 0.5–0.7 s, word stagger 40–60 ms** (we use line mask + 6 px approach blur, 55 ms word stagger, `mg.settle`), type lands sharp and *holds still* while the camera does the moving.
Beat: B2 sentence (2.80), B5 tagline (11.55).
Don't take: OpenAI's point primitive, their sound identity, their fonts.
