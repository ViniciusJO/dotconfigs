#!/usr/bin/env sh

if [[ "$1" == "nvim" ]]; then
  printf "# "
elif [[ "$1" == "nvim_full" ]]; then
  printf "\n--------------------------------------------------------------------------------\n\n#"
fi


date +"%a %d/%m/%Y"
