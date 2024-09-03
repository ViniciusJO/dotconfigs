#!/usr/bin/env bash

function polybar_mon {
  # printf "\n######## %s ########\n\n" "$(date)" >> "$HOME/.local/logs/polybar/polybar_$2.log"
  MONITOR="$2" polybar "$1" & # &>> "$HOME/.local/logs/polybar/polybar_$2.log" &
}

mkdir -p "$HOME"/.local/logs/polybar &>> /dev/null || true

killall polybar &> /dev/null

while true; do
  polybar_mon main "$(polybar -m | grep primary | sed -e 's/: *[^ ]*.*//g')"
  polybar -m | grep -v primary | sed -e 's/: *[^ ]*.*//g' | \
    while read -r MON; do
      polybar_mon pc_sec "$MON"
    done
  inotifywait -e modify -e move -e create -e delete "$HOME"/.config/polybar/**/*.ini -q &> /dev/null
  killall polybar;
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
