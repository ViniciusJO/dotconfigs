#!/usr/bin/env sh

# Bluetooth
paru -S bluez bluez-cups bluez-libs bluez-monitor bluez-tools bluez-utils bluetui pipewire-enable-bluez5
sudo systemctl enable bluetooth

# Audio
paru -S sof-firmware alsa-ucm-conf\n

# Brightness
paru -S brightnessctl

# Enable touchscreen on firefox
if ! (cat /etc/security/pam_env.conf | grep MOZ_USE_XINPUT2 > /dev/null); then
  sudo bash -c 'echo "MOZ_USE_XINPUT2 DEFAULT=1" >> /etc/security/pam_env.conf'
fi

