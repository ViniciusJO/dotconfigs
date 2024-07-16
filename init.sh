#!/usr/bin/bash

REPO="git@github.com:ViniciusJO/dotconfigs.git"

# Git config
gitconfig

git remote remove origin
git remote add origin "$REPO"

# Create dirs
# xdg
mkdir -p $HOME/{Desktop,Documents,Downloads,Music,Pictures/Screenshots,Public,Templates,Videos,.local,.config}

mkdir -p "$HOME"/.local/{logs,share/bob}

# User permisions and groups
sudo usermod -aG audio,disk,docker,kvm,root,tty,uucp "$USER"

# Config limits
sudo sed -i.bak "s/[\n\r]*# End of file/\n@audio\t\t hard\t rtpio\t\t 94\n@audio\t\t hard\t memlock\t unlimited\n$USER\t\t hard\t rtpio\t\t 94\n$USER\t\t hard\t memlock\t unlimited\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/[\n\r]*# End of file/\n@audio;hard;rtpio;94\n@audio;hard;memlock;unlimited\n$USER;hard;rtpio;94\n$USER;hard;memlock;unlimited\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/[\n\r]*# End of file/\n$(echo "@audio;hard;rtpio;94\n@audio;hard;memlock;unlimited\n$USER;hard;rtpio;94\n$USER;hard;memlock;unlimited" | column -s';' -t)\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/\n\n# End of file/\r@audio\t\t hard\t rtpio\t\t 94\r@audio\t\t hard\t memlock\t unlimited\r\r# End of file/" /etc/security/limits.conf

sudo pacman -S --noconfirm --needed --quiet git zsh stow

stow bob/ fonts/ i3/ nchat/ ncspot/ nvim/ octave/ pip/ rofi/ scripts/ sound_effects/ tmux/ wallpapers/ wezterm/ zsh/

# Default wallpaper
echo "$HOME/dotconfigs/wallpapers/.local/share/wallpapers/3DAbstract/nku2ak42wzg31.png" > "$HOME"/.background

(cat /etc/passwd | grep "$USER" | awk -F':' '{print $7}' | grep "zsh" > /dev/null) || chsh -s "/usr/bin/zsh" "$USER"

REQUIRED_PACMAN_PACKAGES="ark ardour bat bob btop calf curl dolphin dragonfly-reverb eza fd feh firefox fzf gcc gdb guitarix gxplugins.lv2 htop i3 lazygit lolcat lua luarocks ly maim make mdcat mesa mesa-demos mesa-utils nano ncspot numlockx octave onlyoffice openssh picom pipewire pipewire-alsa pipewire-autostart pipewire-jack pipewire-pulse pipewire-zeroconf pavucontrol qpwgraph ripgrep rofi screenfetch sox steam thefuck tldr tmux twolame vim wezterm wget wine xclip xorg yabridge yabridgectl zoxide"
REQUIRED_AUR_PACKAGES="brave gxplugins.lv2 lv2-plugins-aur-meta opera opera-ffmpeg-codecs sublime-text-4 systemd-numlockontty visual-studio-code-bin"

existCommand() { command -v "$1" > /dev/null; }

existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git "$HOME"/.local/builds/paru && cd "$HOME"/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git "$HOME"/.local/builds/paruz && cd "$HOME"/.local/builds/paruz && sudo make install && cd - > /dev/null)
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')

# Config pacman & paru
sudo sed -i.bak "s/#BottomUp/BottomUp/" /etc/paru.conf
sudo sed -i.bak "s/#Color/Color/" /etc/pacman.conf
sudo sed -i.bak "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
sudo sed -i.bak -z "s/#\[multilib\]\n*\r*#Include/[multilib]\nInclude/" /etc/pacman.conf

zsh -ic "
  eval \"paru -Syy --noconfirm --needed --quiet $REQUIRED_PACMAN_PACKAGES\"
  eval \"paru -Syy --noconfirm --needed --quiet $REQUIRED_AUR_PACKAGES\"
  
  # Config ly
  sudo sed -i.bak -z \"s/#animate = false/animate = true/\" /etc/ly/config.ini
  sudo sed -i.bak -z \"s/#bigclock/bigclock/\" /etc/ly/config.ini
  sudo systemctl enable ly numLockOnTty.service

  [ ! -f \"$HOME/.ssh/id_ed25519\" ] && ssh-keygen -t ed25519 -q -f \"$HOME/.ssh/id_ed25519\" -N \"\"

	existCommand \"nvm\" && nvm install $NODE_VERSION
	existCommand \"bob\" && bob install latest && bob use latest || printf \"${RED}Command bob not found...\"
	existCommand \"npm\" && npm i -g neovim nodemon pnpm spottydl ts-node typescript yarn || printf \"${RED}Command npm not found...\"
  [ -z $1 ] && reboot
"

# Setup platformio
curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules

# Config git
gitconfig


#libreoffice-extension-writer2latex
