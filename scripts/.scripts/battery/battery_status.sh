#!/bin/sh

ICONS="
10 󰁺
20 󰁻
30 󰁼
40 󰁽
50 󰁾
60 󰁿
70 󰂀
80 󰂁
90 󰂂
100 󰁹
"

CHARGIN_ICONS="
10 󰢜
20 󰂆
30 󰂇
40 󰂈
50 󰢝
60 󰂉
70 󰢞
80 󰂊
90 󰂋
100 󰂅
"

BAT_STATUS="$(printf "%s" "$(acpi | cut -d',' -f1 | cut -d' ' -f3)\n")"
BAT="$(printf "%s" "$(acpi | cut -d',' -f2 | sed -e 's/\%*\s*//g')\n")"
IC="$([ "$BAT_STATUS" = "Charging" ] && printf "%s" "$CHARGIN_ICONS" || printf "%s" "$ICONS" )"
SYMBOL="$(echo "$IC" | \
  while read -r CHARGE; do \
    # printf "%s" "$([ "$(printf "$CHARGE" | cut -d' ' -f1)" -le "$BAT" ] && printf "$CHARGE $BAT")"
    [ "$BAT" -gt "$(printf "%s" "$CHARGE" | cut -d' ' -f1)" ] && \
      [ -z "$FOUND" ] && \
      FOUND=1 && \
      (printf "%s" "$CHARGE" | cut -d' ' -f2) \
  done)"

COLOR_BAT="$(\
  ([ "$BAT" -le "25" ] && printf "%s" "$RED") || \
  ([ "$BAT" -le "50" ] && printf "%s" "$YELLOW") || \
  printf "%s" "$BLUE" \
)"
printf "%s" "$COLOR_BAT$SYMBOL $BAT%%$NC\n"

unset ICONS CHARGIN_ICONS BAT BAT_STATUS IC SYMBOL COLOR_BAT
