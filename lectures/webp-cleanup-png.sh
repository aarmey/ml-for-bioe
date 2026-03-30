#!/usr/bin/env bash

# webp-cleanup-png.sh
#
# Post-render cleanup script for Quarto projects.
#
# During PDF rendering, the Lua filter `webp-to-png.lua` converts
# `.webp` images to `.png` so that LaTeX can include them.
#
# These `.png` files are temporary build artifacts and should not be
# committed to the repository. This script removes any `.png` file
# that has a corresponding `.webp` file with the same basename.
#
# Example:
#   figs/plot.webp  -> kept
#   figs/plot.png   -> removed
#
# The script is executed automatically via `_quarto.yml`:
#
#   project:
#     post-render: "./webp-cleanup-png.sh"
#
# Safe behavior:
#   Only removes *.png files when a sibling *.webp exists.
#
find . -type f -name "*.png" | while read -r png; do
  webp="${png%.png}.webp"
  if [ -f "$webp" ]; then
    rm "$png"
  fi
done
