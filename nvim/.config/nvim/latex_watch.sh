#!/usr/bin/env bash

inotifywait -qmre close_write "$1" --format "%w%f" |
  while read -r f; do [[ "$f" == *_preview.tex ]] || continue;
    lualatex -synctex=on -interaction=nonstopmode -shell-escape -output-directory "$1" "$f"; [[ -f "$f" ]] && pkill -HUP mupdf;
  done
