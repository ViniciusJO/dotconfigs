#!/bin/sh

feh --bg-fill "$(readlink --canonicalize $HOME/.local/share/wallpapers/$(find $HOME/.local/share/wallpapers/ | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" -e ".webp$" | sed -r 's/^.*\/wallpapers\/(.*)$/\1/' | rofi -dmenu -i) | tee $HOME/.background)"
wal -i $(cat $HOME/.background)
