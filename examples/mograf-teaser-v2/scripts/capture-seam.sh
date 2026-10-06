#!/usr/bin/env bash
# Captures the shader seam's real from/to textures from the live composition.
# CAPTURE mode hides grain, vignette and the warp canvas so the textures are clean.
# Re-run after ANY change that affects the frames at the seam times.
set -euo pipefail
cd "$(dirname "$0")/.."
FROM=11.5334; TO=12.1334
sed -i 's/var CAPTURE = false;/var CAPTURE = true;/' index.html
trap 'sed -i "s/var CAPTURE = true;/var CAPTURE = false;/" index.html' EXIT
rm -rf .hyperframes/seam-cap
npx hyperframes snapshot . --at "$FROM,$TO" --no-end -o .hyperframes/seam-cap >/dev/null
cp .hyperframes/seam-cap/frame-00-*.png assets/seam-from.png
cp .hyperframes/seam-cap/frame-01-*.png assets/seam-to.png
echo "captured seam textures: assets/seam-from.png (t=$FROM) assets/seam-to.png (t=$TO)"
