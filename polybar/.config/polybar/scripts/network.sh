#!/usr/bin/env bash

source ~/.config/polybar/scripts/colours.sh
# %{F$(get_color pterc)}

# Detect network interfaces
# WiFi: interface with "wl" prefix
# Ethernet: interface with "en" prefix
WIFI_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(wl)' | head --lines 1)
ETH_IF=$(ip -o link show | cut -d':' -f2 | sed -e 's/ //g' | grep -E '^(en|eth)' | head --lines 1)

# printf "wifi: ${WIFI_IF}\neth: ${ETH_IF}\n"

# Output formatting (Polybar colors optional)
RESET="%{F-}"

# ------------------------------------------------------------
# Check Wi-Fi first
# ------------------------------------------------------------
if [ -n "$WIFI_IF" ]; then
    STATE=$(cat /sys/class/net/$WIFI_IF/operstate 2>/dev/null)

    if [ "$STATE" = "up" ]; then
        # SSID
        SSID=$(iw dev "$WIFI_IF" link | awk -F': ' '/SSID/ {print $2}')

        # Signal quality (percentage)
        SIGNAL=$(awk '/^\s*signal:/ {print int(($2+100)*100/70)}' <<<"$(iw dev "$WIFI_IF" link)" 2>/dev/null)
        # Alternative method from "iwconfig" (fallback)
        if [ -z "$SIGNAL" ]; then
            SIGNAL=$(iwconfig "$WIFI_IF" 2>/dev/null | awk -F'=' '/Quality/ {split($2,a,"/"); print int(a[1]*100/a[2])}')
        fi

        echo " %{F$(get_color pterc)}[${WIFI_IF}] ${SSID} (${SIGNAL}%)%{F-} "
        exit 0
    fi
fi

# ------------------------------------------------------------
# If no WiFI, check Ethernet
# ------------------------------------------------------------
if [ -n "$ETH_IF" ]; then
    STATE=$(cat /sys/class/net/$ETH_IF/operstate 2>/dev/null)

    if [ "$STATE" = "up" ]; then
      echo " %{F$(get_color pterc)}[${ETH_IF}]%{F-} "
        exit 0
    fi
fi

# ------------------------------------------------------------
# If nothing is up, show disconnected
# ------------------------------------------------------------
echo " %{F#444444}[-]%{F-} "

