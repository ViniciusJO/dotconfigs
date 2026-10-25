#!/usr/bin/env sh

# play $SOUND_DIR/message.oga

SOUND_DIR="$HOME/.local/share/sounds"

case "${DUNST_URGENCY:-NORMAL}" in
LOW)
file="$SOUND_DIR/message.oga"
;;
NORMAL)
file="$SOUND_DIR/complete.oga"
;;
CRITICAL)
file="$SOUND_DIR/alarm-clock-elapsed.oga"
;;
*)
exit 0
;;
esac

play "$file"
