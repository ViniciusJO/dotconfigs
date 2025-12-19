#!/usr/bin/env bash

source ~/.config/polybar/scripts/colours.sh

WIFI_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(wl)' | head --lines 1)
ETH_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(en|eth)' | head --lines 1)

RESET="%{F-}"

if [ -n "$WIFI_IF" ]; then
  if (command -v "iw" &> /dev/null); then
    STATE=$(cat /sys/class/net/$WIFI_IF/operstate 2>/dev/null)

    if [ "$STATE" = "up" ]; then
      SSID=$(iw dev "$WIFI_IF" link | awk -F': ' '/SSID/ {print $2}')

      SIGNAL=$(awk '/^\s*signal:/ {print int(($2+100)*100/70)}' <<<"$(iw dev "$WIFI_IF" link)" 2>/dev/null)
      if [ -z "$SIGNAL" ]; then
        SIGNAL=$(iwconfig "$WIFI_IF" 2>/dev/null | awk -F'=' '/Quality/ {split($2,a,"/"); print int(a[1]*100/a[2])}')
      fi

      echo " %{F$(get_color pterc)}[${WIFI_IF}] ${SSID} (${SIGNAL}%)%{F-} "
      exit 0
    else
      echo " %{F#444444}[-]%{F-} "
    fi
  else
    echo " %{F$(get_color psec)}[ net error ]%{F-} ";
    exit 0
  fi
elif [ -n "$ETH_IF" ]; then
  STATE=$(cat /sys/class/net/$ETH_IF/operstate 2>/dev/null)

  if [ "$STATE" = "up" ]; then
    echo " %{F$(get_color pterc)}[${ETH_IF}]%{F-} "
    exit 0
  fi
else
  echo " %{F#444444}[-]%{F-} "
fi

