#!/usr/bin/env bash

[ -z "$DOMAIN_LIST_FILE" ] && echo "Please set DOMAIN_LIST_FILE variable"
[ -z "$DEFAULT_BROWSER" ] && echo "Please set DEFAULT_BROWSER variable"

if echo "$1" | grep -q '^https\?:\/\/'; then
    matching=0
    host=$(echo "$1" | sed -e 's/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/')
    while IFS=, read str method browser; do
        if [[ $method == "host-contains" ]]; then
            if [[ $host == *$str* ]]; then
                matching=1
                break
            fi
        elif [[ $method == "starts-with" ]]; then
            if echo "$1" | grep -q "^https\?:\/\/$str"; then
                matching=1
                break
            fi
        fi

    done < "$DOMAIN_LIST_FILE"

    if [[ $matching -eq 1 ]]; then
        $browser ${*}
        exit 0
    fi
fi

$DEFAULT_BROWSER ${*}
