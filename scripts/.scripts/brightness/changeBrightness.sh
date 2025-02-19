#!/bin/sh

brightness=$(brightnessctl i | grep Current | sed -e 's/^.*(\(.*\)%)/\1/')

increase() {
    if [ "$brightness" -lt 10 ]; then
        brightnessctl s 1%+ > /dev/null 2>&1;
    elif [ "$brightness" -lt 95 ]; then
        brightnessctl s 5%+ > /dev/null 2>&1;
    else
        brightnessctl s 100% > /dev/null 2>&1;
    fi
}

decrease() {
    if [ "$brightness" -gt 10 ]; then
        brightnessctl s 5%- > /dev/null 2>&1;
    elif [ "$brightness" -gt 1 ]; then
        brightnessctl s 1%- > /dev/null 2>&1;
    else
        brightnessctl s 0% > /dev/null 2>&1;
    fi
}

if [ "$1" = "increase" ]; then
    increase
elif [ "$1" = "decrease" ]; then
    decrease
elif [ "$1" = "get" ]; then
  brightnessctl i | grep Current | sed -e 's/^.*(\(.*\)%)/\1/'
elif [ "$1" = "get_with_padding" ]; then
  BRIGHTNESS="$(brightnessctl i | grep Current | sed -e 's/^.*(\(.*\)%)/\1/')"
  [ "${#BRIGHTNESS}" -eq "1" ] && echo " $BRIGHTNESS" || echo "$BRIGHTNESS"
fi
