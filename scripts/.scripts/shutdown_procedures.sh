#!/usr/bin/env sh

# notify-send -u low "SHUTDOWN" "now"
pkill ghostty
play /home/vinicius/.local/share/sounds/service-logout.oga &> /dev/null
# usleep 500
