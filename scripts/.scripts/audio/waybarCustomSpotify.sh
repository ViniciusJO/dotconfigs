#!/bin/zsh
player_status=$(playerctl -p ncspot status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Stopped" ]; then
    echo " "
fi
#!/bin/sh

while true
do
    process=$(. $HOME/.scripts/audio/runningSpotifyProcess.sh)
    # echo $process
    sleep 1
    player_status=$(playerctl -p $process status 2> /dev/null)
    # echo $player_status
    # echo $process

    if [ "$player_status" = "Playing" ]; then
        artist=$(playerctl -p "$process" metadata artist)
        title=$(playerctl -p "$process" metadata title)
        echo '{"text": " '$artist' - '$title'", "class": "custom-spotify", "alt": "Spotify"}'
    elif [ "$player_status" = "Paused" ]; then
        artist=$(playerctl -p "$process" metadata artist)
        title=$(playerctl -p "$process" metadata title)
        echo '{"text": " '"$artist - $title"'", "class": "custom-spotify", "alt": "Spotify (Paused)"}'
    elif [ "$player_status" = "Stopped" ]; then
        echo " "
    fi
    sleep 1
done
