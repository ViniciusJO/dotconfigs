#!/usr/bin/env sh

# i3
i3-msg reload > /dev/null

# polybar
#polybar-msg cmd restart

# quickshell [automatic]

# tmux
export TMUX_COLOR_CONFIG="$HOME/.cache/tmux_color.conf"
[[ -f $TMUX_COLOR_CONFIG ]] && tmux source-file $TMUX_COLOR_CONFIG || echo "deu ruim $TMUX_COLOR_CONFIG"

#zsh
pkill -USR1 -x zsh

# nvim [automatic]

#dunst
dunstctl reload

if [[ -z "$1" ]] || ! [[ "$1" == "false" ]]; then
  notify-send -u normal "Env config reloaded" 
fi

# if [[ -f /tmp/.env_inited ]]; then
#   notify-send -u normal "Env config reloaded" 
# else
#   touch /tmp/.env_inited
# fi
