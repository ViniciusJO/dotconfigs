#!/usr/bin/env bash
#
# Network status for the bar (port of polybar/scripts/network.sh).
#
# Prints one tab separated line, without any formatting:
#   wifi <iface> <ssid> <signal>   wireless interface up
#   eth <iface>                    wired interface up
#   down                           interface present but not connected
#   error                          wireless interface found but `iw` missing
#   (nothing)                      wired interface present but down

WIFI_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(wl)' | head --lines 1)
ETH_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(en|eth)' | head --lines 1)

if [ -n "$WIFI_IF" ]; then
  if ! command -v iw &> /dev/null; then
    echo "error"
    exit 0
  fi

  STATE=$(cat "/sys/class/net/$WIFI_IF/operstate" 2> /dev/null)
  if [ "$STATE" != "up" ]; then
    echo "down"
    exit 0
  fi

  LINK=$(iw dev "$WIFI_IF" link)
  SSID=$(awk -F': ' '/SSID/ {print $2}' <<< "$LINK")
  SIGNAL=$(awk '/^\s*signal:/ {print int(($2+100)*100/70)}' <<< "$LINK" 2> /dev/null)
  if [ -z "$SIGNAL" ]; then
    SIGNAL=$(iwconfig "$WIFI_IF" 2> /dev/null | awk -F'=' '/Quality/ {split($2,a,"/"); print int(a[1]*100/a[2])}')
  fi

  printf 'wifi\t%s\t%s\t%s\n' "$WIFI_IF" "$SSID" "$SIGNAL"
elif [ -n "$ETH_IF" ]; then
  STATE=$(cat "/sys/class/net/$ETH_IF/operstate" 2> /dev/null)
  [ "$STATE" = "up" ] && printf 'eth\t%s\n' "$ETH_IF"
else
  echo "down"
fi
