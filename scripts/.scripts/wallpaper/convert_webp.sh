#!/bin/sh

if [ -z "$1" ]; then
  DIR="."
else
  DIR="$1"
fi

find "$DIR" -type f -iname "*.webp" -exec sh -c '
    name="${1%.*}";
    dwebp "$1" -o "${name}.png";
' _ {} \;
