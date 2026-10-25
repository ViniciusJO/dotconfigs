#!/bin/sh

# i3-msg -t subscribe -m '["shutdown"]' |
  # while IFS= read -r event; do
  #     change=$(printf '%s\n' "$event" | jq -r '.change // empty')
  #
  #     case "$change" in
  #         exit)
  #             $HOME/.scripts/shutdown_procedures.sh
  #             ;;
  #         restart)
  #             # Optional: play a separate restart sound.
  #             # :
  #             $HOME/.scripts/shutdown_procedures.sh
  #             ;;
  #     esac
  # done

# rm -f /tmp/i3-shutdown-events.log

i3-msg -t subscribe -m '["shutdown"]' |
    while IFS= read -r event; do
        # printf '%s\n' "$event" >> /home/vinicius/i3_event.log
        $HOME/.scripts/shutdown_procedures.sh
    done
