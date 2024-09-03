#!/bin/bash

function capslock() {
  caps=$(xset -q | grep Caps | awk '{ print $4 }')
  [ "$caps" == 'off' ] && echo " " || echo "󰌎"
}

function numlock {
  num=$(xset -q | grep Num | awk '{ print $8 }')
  [ "$num" == 'off' ] && echo " " || echo ""
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
  fi

  if [ "$1" == "-n"  ]; then
    numlock
  fi

  if [ "$1" == "-s"  ]; then
    scroll
  fi
}

main "$1"
