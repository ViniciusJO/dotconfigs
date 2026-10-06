#!/usr/bin/env bash
#
# Starts (or restarts) the bar, replacing polybar/launch.sh.
#
# Quickshell creates one bar per screen by itself and hot reloads when any
# file of this config changes, so no monitor loop or inotify watch is needed.
#
# i3: exec_always --no-startup-id /path/to/quickshell/launch.sh

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

killall -q polybar &> /dev/null
qs kill -p "$CONFIG_DIR" &> /dev/null
qs -p "$CONFIG_DIR" -d &> /dev/null
