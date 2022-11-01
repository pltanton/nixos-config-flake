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

DDC_BRIGHTNESS_FILE="/tmp/brightness_next_ddc_brightness"
NEXT_DDC_EXECUTION_FILE="/tmp/brightness_next_ddc_execution"

cur_time=$(($(date +%s3%N)))

if [ -f "$NEXT_DDC_EXECUTION_FILE" ]; then
  next_ddc_execution=$(<"$NEXT_DDC_EXECUTION_FILE")
fi

cur_brightness=$(light -G | cut -d'.' -f1)
echo "$cur_brightness" >"$DDC_BRIGHTNESS_FILE"

if [ -z "$next_ddc_execution" ] || [ "$next_ddc_execution" -le "$cur_time" ]; then
  echo $((cur_time + 190)) >"$NEXT_DDC_EXECUTION_FILE"
  (
    sleep 0.2
    ddcutil setvcp 10 "$(<"$DDC_BRIGHTNESS_FILE")" 2>/dev/null
  ) &
fi

echo "$cur_brightness"
