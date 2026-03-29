#!/usr/bin/env sh

source ~/.config/polybar/scripts/colours.sh

MODE="$(rotatron mode 2>&1)"

if [[ "$MODE" = "AUTOMATIC" ]]; then
  printf "%%{F#000000}%%{B$(get_color pcont)} A %%{F-}%%{B-}";
elif [[ "$MODE" = "MANUAL" ]]; then
  printf "%%{F$(get_color pcont)}%%{B#000000} M %%{F-}%%{B-}";
else
  printf "$MODE"
fi

