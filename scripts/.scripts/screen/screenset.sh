#!/usr/bin/sh

#YELLOW='\033[1;33m'
#NC='\033[0m' # No Color

# Has $1<this> in $2<that>
has() {
    echo "$1" | grep "$2" > /dev/null
}

MONITORS=$(xrandr | grep -e " connected" | cut -d " " -f 1)

has "$MONITORS" "HDMI-1" && xrandr --output HDMI-1 --primary
# Align centers of DP-2 with HDMI-1
has "$MONITORS" "DP-2" &&\
  xrandr --output DP-2 -s 1920x1080 --rotate right --left-of HDMI-1 \
  $(has "$MONITORS" "HDMI-1" || echo "--primary")
has "$MONITORS" "eDP-1" &&\
  xrandr \
    --output eDP-1 \
    --rotate $([ -n "$1" ] && echo $1 || echo normal)\
    $([ -n "$2" ] && echo "-s $2")\
    $(has "$MONITORS" "HDMI-1" || has "$MONITORS" "DP-2" || echo --primary);
numlockx on


# if [ "$?" -ne 0 ]; then printf "None of the monitors where identified in the configs:\n$YELLOW$MONITORS$NC\n"; fi
