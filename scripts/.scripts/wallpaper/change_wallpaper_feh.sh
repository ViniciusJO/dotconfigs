#!/bin/sh

pickBG() {
  # feh --no-xinerama --bg-fill "$(readlink --canonicalize "$HOME"/.local/share/wallpapers/$(find "$HOME"/.local/share/wallpapers/ | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" | sed -r 's/^.*\/wallpapers\/(.*)$/\1/' | rofi -dmenu -i -p "Select Wallpaper: " -window-title "Wallpaper Changer" -monitor | while read -r SELECTION; do feh --no-xinerama --bg-fill "$SELECTION"; done) | tee "$HOME"/.background)"
  #wal -i $(cat $HOME/.background)
  # find $HOME/.local/share/wallpapers/ | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" | sed -r 's/^.*\/wallpapers\/(.*)$/\1/' | fzf --preview="feh --bg-fill --no-xinerama $HOME/.local/share/wallpapers/{}" | sed -r 's/(.*)/$HOME\/.local\/share\/wallpapers\/\1/g' > ~/.background
  readlink --canonicalize "$HOME/.local/share/wallpapers/$( 
    (printf "%s\n%s" "$(cat "$HOME/.background")" "$(find "$HOME"/.local/share/wallpapers/)" |
      grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" |
      sed -r 's/^.*\/wallpapers\/(.*)$/\1/' |
      fzf --preview="printf \"Colorscheme:\n\n\" && feh --bg-fill --no-xinerama $HOME/.local/share/wallpapers/{} && color_juicer $HOME/.local/share/wallpapers/{} 4 15 && (polybar-msg cmd restart; i3-msg reload) &> /dev/null") || cat "$HOME"/.background
  )" > ~/.background
}

compareStr() {
  if [ ! -z "$(echo "$1" | grep -e "$2")" ]; then true; else false; fi
}

compFileType() {
  compareStr "$(file "$1" | awk '{ print $2 }')" "$2"
}

changeBG() {
  if [ ! -z "$1" ] && [ -f "$1" ]; then
    if compFileType "$1" "PNG" || compFileType "$1" "JPEG" || compFileType "$1" "GIF"; then
      feh --no-xinerama --bg-fill "$1"
      echo "$1" >"$HOME"/.background
      #echo "img"
    elif compFileType "$1" "ASCII"; then
      #echo "textfile"
      changeBG "$(cat "$1")"
    else
      #echo "pick-ignoring"
      pickBG
    fi
  else
    #echo "pick"
    pickBG
  fi
  
  color_juicer "$(cat ~/.background)" 6 5
  polybar-msg cmd restart
  i3-msg reload
  # sleep 10
}

changeBG "$1"
