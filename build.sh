#!/usr/bin/env bash
set -euo pipefail

# Builds the single CV project in a Docker container and writes the PDF
# into the target_simple folder.

IMAGE="texlive/texlive:latest"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$ROOT/target_simple"

# Deployment variable: set CV_LANG=en for the English CV, defaults to German.
CV_LANG="${CV_LANG:-de}"
case "$CV_LANG" in
  de) MAIN_TEX="simpleCV.tex" ;;
  en) MAIN_TEX="simpleCV_EN.tex" ;;
  *)
    echo "Unknown CV_LANG '$CV_LANG' (expected 'de' or 'en')" >&2
    exit 1
    ;;
esac

mkdir -p "$OUTPUT_DIR"

echo "==> Building CV from src/simple/$MAIN_TEX"
docker run --rm \
  -v "$ROOT:/data" \
  -w "/data/src/simple" \
  "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
    -output-directory="/data/target_simple" "$MAIN_TEX"

find "$OUTPUT_DIR" -type f ! -name '*.pdf' -delete
mv "$OUTPUT_DIR/${MAIN_TEX%.tex}.pdf" "$OUTPUT_DIR/simpleCV_${CV_LANG}.pdf"
