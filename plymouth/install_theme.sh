#!/usr/bin/env sh

set -e

if [[ -d /usr/share/plymouth/themes/archcraft ]]; then
  printf "archcraft plymouth theme already installed...\n"
  exit 0;
fi

command -v "plymouth-set-default-theme";

sudo find archcraft -type f -exec \
  install -Dm 644 "{}" "/usr/share/plymouth/themes/{}" \;

sudo plymouth-set-default-theme archcraft

