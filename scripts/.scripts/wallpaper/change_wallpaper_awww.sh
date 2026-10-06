#!/bin/sh

wbg() {
  if [[ -f "$1" ]]; then
    awww img "$1" -t random --transition-duration=0.01
    # pkill swaybg
    # swaybg -i "$1" -m fill &
    # disown
  else
    false
  fi
}

print_file_path_if_exists() {
  CANONICALIZED="$(readlink --canonicalize "$1")"
  stat "$CANONICALIZED" &> /dev/null && printf "$CANONICALIZED"
}

preview() {
  printf "
  BG_VAR=%s
  wbg() {
    if [[ -f \"\$1\" ]]; then
      awww img \"\$1\" -t random --transition-duration=0.8
      # pkill swaybg
      # swaybg -i \"\$1\" -m fill &
      # disown
    else
      false
    fi
  }

  print_file_path_if_exists() {
    CANONICALIZED=\"\$(readlink --canonicalize \"\$1\")\"
    stat \"\$CANONICALIZED\" &> /dev/null && printf \"\$CANONICALIZED\"
  }

  printf \"Colorscheme:\n\n\" && \
    (wbg \$HOME/.local/share/wallpapers/\$BG_VAR 2> /dev/null || wbg \$HOME/Pictures/wallpapers/\$BG_VAR) && \
    (color_juicer \"\$(print_file_path_if_exists \$BG_VAR)\" 4 15 2> /dev/null) && \
    &> /dev/null
  " "$1"
  # color_juicer "$1" 6 5
}

pickBG() {
  NEW_BG=$(printf "%s\n%s\n%s" "$(cat "$HOME/.background")" "$(find "$HOME"/.local/share/wallpapers/)" "$(find "$HOME"/Pictures/wallpapers/)" |
      grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" |
      sed -r 's/^.*\/wallpapers\/(.*)$/\1/' |
      fzf --preview="$(preview "{}")")
  # (print_file_path_if_exists "$HOME/.local/share/wallpapers/$NEW_BG" || print_file_path_if_exists "$HOME/Pictures/wallpapers/$NEW_BG" || cat "$HOME"/.background) > ~/.background
  # printf "${NEW_BG}"
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
      wbg "$1"
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

  # color_juicer "$(cat ~/.background)" 6 5
  # color_juicer "$1" 6 5
  # polybar-msg cmd restart
  # sleep 10
}

changeBG "$1"
