#!/usr/bin/env sh

# Kill the existing swaybg process if it's running
pkill swaybg

# Run swaybg in the background and disown it so the script exits instantly
swaybg -i "$1" -m fill &
disown

