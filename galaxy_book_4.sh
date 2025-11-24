#!/usr/bin/env sh

# Bluetooth
paru -S bluez bluez-cups bluez-libs bluez-monitor bluez-tools bluez-utils bluetui pipewire-enable-bluez5
sudo systemctl enable bluetooth

# Audio
paru -S sof-firmware alsa-ucm-conf\n

# Brightness
paru -S brightnessctl

