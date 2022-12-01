#!/usr/bin/env bash

POSITIONAL=()
INCREASE=false
DECREASE=false
DELTA=0

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -d | --delta)
      DELTA="$2"
      shift # past argument
      shift # past value
      ;;
    --inc)
      INCREASE=true
      shift # past argument
      ;;
    --dec)
      DECREASE=true
      shift # past argument
      ;;
    *)                   # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift              # past argument
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

if [ "$INCREASE" = "true" ]; then
  light -A "$DELTA"
fi

if [ "$DECREASE" = "true" ]; then
  light -U "$DELTA"
fi

DDC_LOCK_FILE="/tmp/ddc_lock_file"

cur_time=$(($(date +%s3%N)))

cur_brightness=$(light -G | cut -d'.' -f1)

if [ ! -f "$DDC_LOCK_FILE" ] || [ "$(<$DDC_LOCK_FILE)" -le "$cur_time" ]; then
  (
    now_time=$(($(date +%s3%N)))
    while [ "$(<$DDC_LOCK_FILE)" -ge "$now_time" ]; do
      sleep 0.2
      now_time=$(($(date +%s3%N)))
    done
    ddcutil setvcp 10 "$(light -G | cut -d'.' -f1)" >/dev/null 2>&1
  ) &
fi

echo $((cur_time + 205)) >"$DDC_LOCK_FILE"

echo "$cur_brightness"
