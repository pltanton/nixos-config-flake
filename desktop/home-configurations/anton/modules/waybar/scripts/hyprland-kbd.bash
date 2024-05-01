#!/usr/bin/env bash

layout="en"
if hyprctl devices | grep -q "active keymap: Russian"; then
    layout="ru"
fi
echo "{\"text\": \"$layout\"}"

function handle {
    if [[ ${1:0:12} == "activelayout" ]]; then
        layout=$(echo "${1:14}" | cut -d',' -f2)
        if [[ "$layout" == "English (Dvorak)" ]]; then
            layout="en"
        elif [[ "$layout" = "Russian" ]]; then
            layout="ru"
        fi
        echo "{\"text\": \"$layout\"}"
    fi
}

nc -U /tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
