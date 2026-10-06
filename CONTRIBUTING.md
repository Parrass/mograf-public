# Contributing

## Add a piece to the awesome list

We list motion graphics made with Claude (Opus 5.5 / Claude Code), with any runtime: HyperFrames, Remotion, GSAP/HTML, Three.js, Motion Canvas, Lottie, or something else.

**What gets in**
- A public post or page with the video (X, YouTube, Bluesky, LinkedIn, a personal site, a GitHub repo).
- Claude did most of the motion work, and the post says so.
- Something is notable: an idea, a technique, a published prompt, or open source. A plain "look what AI made" usually isn't enough.
- Submitting your own work is fine. So is submitting someone else's; credit them.

**How**
1. Fork the repo and add one row to the **Showcase** table in `awesome-claude-motion.md`:

   ```
   | @handle | [Short title](https://link) | One line, in your words, on what's notable | Tool | yes/no/partial |  |
   ```

   - **Creator:** the creator's handle, not the reposter's.
   - **Link:** the original post.
   - **Prompt available:** `yes` if the full prompt is public, `partial` if only an excerpt is, `no` otherwise.
   - **mograf remake:** leave this column empty. We fill it in.
2. Link only. Don't add video files, GIFs, screenshots or copied prompt text to the repo.
3. Open a PR titled `Add: <title> by @handle`.

Or open an issue with the link and we'll add it.

**Removal.** If you're a creator and want your piece removed or re-credited, open an issue or email via mograf.si. We'll do it, no questions asked.

## Improve the skills

Issues and PRs to `plugins/mograf/skills/` are welcome:

- a rule that's wrong;
- a threshold that misfires;
- a review step that hangs on your setup;
- an equivalent command for Remotion or another runtime.

Keep changes concrete (numbers, not adjectives). Contributions are accepted under the MIT license.

## Example kits

Don't add third-party assets unless their license allows redistribution (OFL fonts, MIT/Apache code with headers, CC0 audio). Every non-original file needs a row in the kit's `ASSETS.md`.
