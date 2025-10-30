#!/bin/bash

function bcapslock() {
  caps=$(xset -q | grep Caps | awk '{ print $4 }')
  [ "$caps" != 'off' ]
}

function bnumlock {
  num=$(xset -q | grep Num | awk '{ print $8 }')
  [ "$num" != 'off' ]
}

function capslock() {
  caps=$(xset -q | grep Caps | awk '{ print $4 }')
  echo "$([ "$caps" == 'off' ] && echo "%{F#555555}" || echo $2)󰌎%{F-}"
}

function numlock {
  num=$(xset -q | grep Num | awk '{ print $8 }')
  echo "$([ "$num" == 'off' ] && echo "%{F#555555}%{F-}" || echo "")"
  # [ "$num" == 'off' ] && echo "%{F#555555}" || echo "%{F\${dyn_colors.psec}}"
}

function scroll() {
  scroll=$(xset -q | grep Scroll | awk '{ print $12 }')
  [ "$scroll" == 'off' ] && echo " " || echo "󰵖"
}

main () {
  if [ "$1" == "-a"  ]; then
    echo " $(capslock) $(numlock)"
  fi

  if [ "$1" == "-c"  ]; then
    capslock
    return
  fi

  if [ "$1" == "-n"  ]; then
    numlock
    return
  fi

  if [ "$1" == "-bc"  ]; then
    bcapslock
    return $?
  fi

  if [ "$1" == "-bn"  ]; then
    bnumlock
    return $?
  fi

  if [ "$1" == "-s"  ]; then
    scroll
    return
  fi
}

main "$1"
