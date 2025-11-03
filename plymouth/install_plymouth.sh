#!/usr/bin/env bash

CONF="/etc/mkinitcpio.conf"

# Read the HOOKS line (without comments)
# hooks_line=$(grep -E '^\s*HOOKS=\(.*\)' "$CONF")

hooks=$(grep -E '^\s*HOOKS=\(.*\)' "$CONF" | sed -E 's/.*HOOKS=\((.*)\).*/\1/')

# Extract the contents between parentheses
# hooks=($(echo "$hooks_line" | sed -E 's/.*HOOKS=\((.*)\).*/\1/'))

# Check if plymouth is already present
if [[ " ${hooks[*]} " =~ " plymouth " ]]; then
  echo "plymouth already in HOOKS"
else
  # We'll insert plymouth after 'udev' if it exists, else after 'base'
  new_hooks=()
  inserted=false
  # systemd=-1
  # encrypt=-1
  # sd_encrypt=-1
  # i=0
  # for hook in $hooks; do
  #   if [[ $hook == "systemd" ]]; then systemd=$i;
  #   elif [[ $hook == "encrypt" ]]; then encrypt=$i;
  #   elif [[ $hook == "sd-encrypt" ]]; then sd_encrypt=$i;
  #   fi
  #   i=$((i + 1));
  # done

  # (
  #   [[ "$systemd" -lt "0" ]] ||
  #   (
  #     ([[ "$encrypt" -lt "0"]] || [[ "0" -gt "$systemd" ]]) &&
  #     ([[ "$sd_encrypt" -lt "0"]] || [[ "$sd_encrypt" -gt "$systemd" ]])
  #   )
  # ) ||
  #   printf "${RED}Invalid mkinitcpio HOOKs order${NC}: ${hooks}\n" &&
  #   exit 1

  if [[ "$systemd" -ge "0" ]]; then
    for hook in $hooks; do
      new_hooks+=("$hook")
      if [[ $hook == "systemd" ]]; then
        new_hooks+=("plymouth")
        inserted=true
      fi
    done
  else
    for hook in $hooks; do
      new_hooks+=("$hook")
      if [[ $hook == "udev" ]]; then
        new_hooks+=("plymouth")
        inserted=true
      fi
    done
  fi

  # If we didn't find a good spot, append it
  if ! $inserted; then
    new_hooks+=("plymouth")
  fi

  # Rebuild the new line
  new_line="HOOKS=(${new_hooks[*]})"

  # Replace in file safely
  sudo sed -i -E "s|^\s*HOOKS=\(.*\)|$new_line|" "$CONF"
  echo "Updated HOOKS line: ${new_line}"

  CONF="/etc/default/grub"
  params=(quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0 plymouth.ignore-serial-consoles)

  line=$(grep '^GRUB_CMDLINE_LINUX_DEFAULT=' "$CONF" || echo 'GRUB_CMDLINE_LINUX_DEFAULT=""')
  current=$(echo "$line" | sed -E 's/.*="(.*)"/\1/')

  for p in "${params[@]}"; do
    [[ " $current " =~ " $p " ]] || current="$current $p"
  done

  new_line="GRUB_CMDLINE_LINUX_DEFAULT=\"${current# }\""
  sudo sed -i -E "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|$new_line|" "$CONF"

  # GRUB_CONF="/etc/default/grub"
  #
  # # Desired parameters
  # PLYMOUTH_PARAMS="quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0 plymouth.ignore-serial-consoles"
  #
  # # Replace or append in GRUB_CMDLINE_LINUX_DEFAULT
  # if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_CONF"; then
  #   sudo sed -i -E "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT=\"${PLYMOUTH_PARAMS}\"|" "$GRUB_CONF"
  # else
  #   echo "GRUB_CMDLINE_LINUX_DEFAULT=\"${PLYMOUTH_PARAMS}\"" | sudo tee -a "$GRUB_CONF" >/dev/null
  # fi

  sudo mkinitcpio -P linux
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi


