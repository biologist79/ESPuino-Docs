#!/usr/bin/env bash
#
# Optimize images for the ESPuino handbook: downscale to a sane max width and
# recompress. Prefers ImageMagick (mogrify) when available, otherwise falls
# back to macOS' built-in `sips` (no installation needed).
#
# Idempotent: an image that is already within the width/size targets is left
# untouched, so this can run over and over (and from the pre-commit hook)
# without progressively degrading quality.
#
# Usage:
#   tools/optimize-images.sh                 # optimize every image under docs/assets/
#   tools/optimize-images.sh path/to/img.png # optimize the given file(s)
#
set -euo pipefail

MAXW=1600                  # maximum width in pixels
QUALITY=82                 # JPEG quality (1-100)
SIZE_CAP=$((500 * 1024))   # bytes; a file already <= this AND <= MAXW wide is skipped

have() { command -v "$1" >/dev/null 2>&1; }

img_width() {
	if have magick; then
		magick identify -format '%w' "$1" 2>/dev/null || echo 0
	elif have identify; then
		identify -format '%w' "$1" 2>/dev/null || echo 0
	else
		sips -g pixelWidth "$1" 2>/dev/null | awk '/pixelWidth/{print $2}'
	fi
}

file_size() { stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null || echo 0; }

optimize_one() {
	f="$1"
	[ -f "$f" ] || return 0
	w="$(img_width "$f")"; w="${w:-0}"
	sz="$(file_size "$f")"; sz="${sz:-0}"

	# Idempotency guard: already small enough -> leave it alone.
	if [ "$w" -le "$MAXW" ] && [ "$sz" -le "$SIZE_CAP" ]; then
		return 0
	fi

	ext="$(printf '%s' "${f##*.}" | tr '[:upper:]' '[:lower:]')"

	if have mogrify; then
		# '>' only shrinks images larger than the geometry, never enlarges.
		mogrify -resize "${MAXW}x${MAXW}>" -strip -quality "$QUALITY" "$f"
	else
		# sips fallback (bundled with macOS)
		if [ "$w" -gt "$MAXW" ]; then
			sips --resampleWidth "$MAXW" "$f" --out "$f" >/dev/null
		fi
		case "$ext" in
			jpg | jpeg)
				sips -s format jpeg -s formatOptions "$QUALITY" "$f" --out "$f" >/dev/null
				;;
			# PNG has no lossy "quality"; the resize above is the main win.
		esac
	fi

	printf 'optimized: %s -> %s bytes (width %s)\n' "$f" "$(file_size "$f")" "$(img_width "$f")"
}

if ! have mogrify && ! have sips; then
	echo "error: neither ImageMagick (mogrify) nor sips found." >&2
	echo "       Install ImageMagick (\`sudo port install ImageMagick\`) or run on macOS." >&2
	exit 1
fi

if [ "$#" -gt 0 ]; then
	for f in "$@"; do optimize_one "$f"; done
else
	if [ -d docs/assets ]; then
		find docs/assets -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) 2>/dev/null |
			while IFS= read -r f; do optimize_one "$f"; done
	fi
fi
