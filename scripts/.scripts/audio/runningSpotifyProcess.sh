#!/bin/zsh

process=""
if [ "$(pgrep "spotify")" -ne "0" ]; then 
    process="spotify"
elif [ "$(pgrep "ncspot")" -ne "0" ]; then 
    process="ncspot"
fi
echo $process
