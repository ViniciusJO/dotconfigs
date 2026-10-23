#!/usr/bin/env sh

if stat "$HOME/.local/share/wallpapers/$1" &> /dev/null; then
  IMG_PATH="$HOME/.local/share/wallpapers/$1"
elif stat "$HOME/Pictures/wallpapers/$1" &> /dev/null; then
  IMG_PATH="$HOME/Pictures/wallpapers/$1"
else
  return 1
fi

feh --bg-fill --no-xinerama $IMG_PATH 2> /dev/null

printf \"Colorscheme:\n\n\"
# color_juicer $IMG_PATH 4 15 2> /dev/null
~/Code/color_juicer/zig-out/bin/color_juicer -# 4 -c '#FFFFFF' -t ~/.config/color_juicer/template $IMG_PATH 2> /dev/null

~/.scripts/wallpaper/reload_env.sh
