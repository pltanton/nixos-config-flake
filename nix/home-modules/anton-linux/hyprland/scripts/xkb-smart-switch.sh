#!/usr/bin/env bash
set -e

ACTIVE_KEYMAP=$(hyprctl devices -j | jq -r '.keyboards.[] | select(.main).active_keymap')

if [ "$ACTIVE_KEYMAP" = "English (Dvorak)" ]; then
    hyprctl switchxkblayout current next
else
    hyprctl switchxkblayout current 0
fi