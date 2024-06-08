#!/bin/sh

function pickBG () {
    feh --no-xinerama --bg-fill "$(readlink --canonicalize $HOME/.local/share/wallpapers/$(find $HOME/.local/share/wallpapers/ | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" -e ".webp$" | sed -r 's/^.*\/wallpapers\/(.*)$/\1/' | rofi -dmenu -i -p "Select Wallpaper: " -window-title "Wallpaper Changer") | tee $HOME/.background)"
    #wal -i $(cat $HOME/.background)
}

function compareStr () {
    if [ ! -z $(echo "$1" | grep -e "$2") ]; then true; else false; fi
}

function compFileType() {
    compareStr "$(file "$1" | awk '{ print $2 }')" "$2"
}

function changeBG() {
    if [ ! -z $1 ] && [ -f $1 ]; then 
        if compFileType "$1" "PNG" || compFileType "$1" "JPEG" || compFileType "$1" "GIF" ]; then
            feh --no-xinerama --bg-fill "$1"
            echo "$1" > $HOME/.background
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
}

changeBG $1