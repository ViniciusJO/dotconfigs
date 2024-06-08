#!/usr/bin/sh

# Has $1<this> in $2<that>
function has() {
    echo "$1" | grep "$2" > /dev/null
}

MONITORS=$(xrandr | grep -e " connected" | cut -d " " -f 1)

has "$MONITORS" "HDMI-1" && xrandr --output HDMI-1 --primary
has "$MONITORS" "DP-2" && xrandr --output DP-2 -s 1920x1080 --rotate right --left-of HDMI-1 $(has "$MONITORS" "HDMI-1" && echo "--primary")

#has "$MONITORS" "HDMI-1" && echo "TEM HDMI"
#has "$MONITORS" "DP-2" && echo "TEM TUDU"
#has "$MONITORS" "DP-9" && echo "TEM NADA"