#!/usr/bin/env bash

# set -e

find ./. -type f -name '*.svg' -exec sed -i "s/#$1/#$2/" {} +

for file in *.svg; do
    inkscape \
        --export-type=png \
        --export-background-opacity=0 "$file" \
        --export-width=186 --export-height=186
done
