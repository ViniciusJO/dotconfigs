#!/usr/bin/sh

REPO="git@github.com:ViniciusJO/dotconfigs.git"

git remote remove origin
git remote add origin "$REPO"

sudo pacman -S --noconfirm --needed --quiet git zsh stow

stow bob/ fonts/ i3/ nchat/ ncspot/ nvim/ octave/ pip/ rofi/ scripts/ sound_effects/ tmux/ wallpapers/ wezterm/ zsh/

# Default wallpaper
echo "$HOME/dotconfigs/wallpapers/.local/share/wallpapers/3DAbstract/nku2ak42wzg31.png" > $HOME/.background

(cat /etc/passwd | grep "$USER" | awk -F':' '{print $7}' | grep "zsh" > /dev/null) || chsh -s "/usr/bin/zsh" "$USER"

REQUIRED_PACMAN_PACKAGES="ardour bat bob btop calf curl dolphin dragonfly-reverb eza fd feh firefox fzf gcc gdb guitarix gxplugins.lv2 htop i3 lazygit lolcat lua luarocks ly maim make mesa mesa-demos mesa-utils nano ncspot numlockx onlyoffice openssh pavucontrol pipewire pipewire-alsa pipewire-autostart pipewire-jack pipewire-pulse pipewire-zeroconf qpwgraph ripgrep rofi screenfetch steam thefuck tmux vim wezterm wget wine xclip xorg zoxide"
REQUIRED_AUR_PACKAGES="brave systemd-numlockontty opera sublime-text-4"gxplugins.lv2

function existCommand { command -v "$1" > /dev/null; }

existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git $HOME/.local/builds/paru && cd $HOME/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git $HOME/.local/builds/paruz && cd $HOME/.local/builds/paruz && sudo make install && cd - > /dev/null)
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')

# Config pacman & paru
sudo sed -i.bak "s/#BottomUp/BottomUp/" /etc/paru.conf
sudo sed -i.bak "s/#Color/Color/" /etc/pacman.conf
sudo sed -i.bak "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
sudo sed -i.bak -z "s/#\[multilib\]\n*\r*#Include/[multilib]\nInclude/" /etc/pacman.conf

# Create dirs
mkdir -p $HOME/.local/{logs,share/bob}

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
