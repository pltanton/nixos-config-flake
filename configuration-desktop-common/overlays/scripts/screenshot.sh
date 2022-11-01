#!/usr/bin/env bash
set -e

e_flag=''
while getopts 'e' OPTION; do
  case "$OPTION" in
    e)
      e_flag=true
      ;;
    *)
      echo "Unknown flag: use -e flag to edit screenshot you take before saving it"
      exit 1
      ;;
  esac
done
shift "$((OPTIND - 1))"

mkdir -p ~/Screenshots
FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
if [ "$e_flag" = true ]; then
  grim -g "$(slurp)" - | swappy -f - -o "$FILE_PATH"
else
  grim -g "$(slurp)" "$FILE_PATH"
fi

wl-copy -t image/png <"$FILE_PATH"
notify-send -i "$FILE_PATH" -t 10000 "Screenshot taken" "Screenshot stored in file $FILE_PATH and clipboard"
