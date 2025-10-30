#!/usr/bin/env bash

function takeMonitorName { echo "$1" | sed -e 's/: *[^ ]*.*//g'; }

function takeMonitorWidth { echo "$1" | cut -d' ' -f2 | cut -d'+' -f1 | cut -d'x' -f1; }

function takeMonitorHeight { echo "$1" | cut -d' ' -f2 | cut -d'+' -f1 | cut -d'x' -f2; }

function min { octave --eval "$([ "$1" -gt "$2" ] && echo "$2" || echo "$1")" | cut -d' ' -f3; }

function minMonitorSide { min "$(takeMonitorWidth "$1")" "$(takeMonitorHeight "$1")"; }

function fontSize { octave --eval "floor((4/1080)*$1 + 6)" | cut -d' ' -f3; }

  # printf "\n######## %s ########\n\n" "$(date)" >> "$HOME/.local/logs/polybar/polybar_$2.log"
function polybar_mon {
  export MONITOR="$2"
  export FONT="$3"
  polybar "$1" &>> "$HOME/.local/logs/polybar/polybar_$2.log" &
  unset MONITOR FONT
}

mkdir -p "$HOME"/.local/logs/polybar &>> /dev/null || true

killall polybar &> /dev/null

MAINMON=$(polybar -m)
polybar_mon main "$(takeMonitorName "$MAINMON")" "$(fontSize "$(minMonitorSide "$MAINMON")")"
polybar -m | grep -v primary | \
  while read -r MON; do
    polybar_mon pc_sec "$(takeMonitorName "$MON")" "$(minMonitorSide "$MON")"
  done
while true; do
  inotifywait -e modify -e move -e create -e delete "$HOME"/.config/polybar/**/*.ini -q &> /dev/null
  polybar-msg cmd restart
done

# polybar -m | sed -e 's/: *[^ ]*//g' | sed -e 's/(primary)/#/g'
#
# Terminate already running bar instances
# killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
# polybar top -c ~/.config/polybar/config.ini &

# if [[ $(xrandr -q | grep '^DP-1 connected') ]]; then
#   polybar top_external -c ~/.config/polybar/config.ini &
# fi
#
# if [[ $(xrandr -q | grep '^HDMI-1 connected') ]]; then
#   polybar top_external_hdmi -c ~/.config/polybar/config.ini &
# fi

# killall polybar && while true; do MONITOR=HDMI-1 polybar main & MONITOR=DP-2 polybar pc_sec & inotifywait -e modify -e move -e create -e delete $HOME/.config/polybar --quiet &> /dev/null || true && killall polybar; done
