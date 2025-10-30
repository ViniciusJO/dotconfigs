swww img "$(\
    find ~/.local/share/wallpapers/ \
    | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$" \
    | wofi --gtk-dark --dmenu -p "Chose wallpaper" --allow-images -i --sort-order=alphabetical \
    | tee ~/.background \
    )" --transition-fps 30 --transition-type "any" --transition-duration 3 \
    && wal -n -i "$(swww query | cut -d , -f 3 | cut -d : -f 3 | xargs)" \
    && pkill waybar && waybar &

