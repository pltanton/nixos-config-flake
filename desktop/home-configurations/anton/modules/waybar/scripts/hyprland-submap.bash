#!/usr/bin/env bash

function handle {
    if [[ ${1:0:6} == "submap" ]]; then
        echo "{\"text\": \"${1:8}\"}"
    fi
}

nc -U /tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
