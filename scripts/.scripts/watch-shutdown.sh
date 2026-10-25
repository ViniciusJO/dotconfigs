#!/bin/sh
set -eu

exec /usr/bin/systemd-inhibit \
    --what=shutdown \
    --mode=delay \
    --who="Desktop shutdown sound" \
    --why="Play sound before audio services stop" \
    "$HOME/.scripts/wait-shutdown.sh"

