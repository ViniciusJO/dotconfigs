#!/usr/bin/env bash

source ~/.config/polybar/scripts/colours.sh

BAT=$(ls /sys/class/power_supply/ | grep 'BAT' | column | cut -d ' ' -f 1)

if [[ -z "$BAT" ]]; then
  printf ""
  exit 0
fi

STATUS=$(cat /sys/class/power_supply/$BAT/status)
PERC=$(cat /sys/class/power_supply/$BAT/capacity)

if [[ "$PERC" -ge 99 ]]; then
  echo " %{F$(get_color pterc)}  Full %{F-}"
  exit 0
fi

if [ "$STATUS" = "Charging" ]; then
    ICON="%{F$(get_color pprim)}"
else
    if   [ "$PERC" -ge 90 ]; then ICON="%{F$(get_color psec)}"
    elif [ "$PERC" -ge 70 ]; then ICON="%{F$(get_color psec)}"
    elif [ "$PERC" -ge 50 ]; then ICON="%{F$(get_color psec)}"
    elif [ "$PERC" -ge 30 ]; then ICON="%{F$(get_color psec)}"
    else ICON="%{F$(get_color psec)}"
    fi
fi

echo " $ICON  ${PERC}%% %{F-}"

