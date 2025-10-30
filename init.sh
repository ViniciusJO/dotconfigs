#!/usr/bin/bash
BLACK='\033[0;30m'     
RED='\033[0;31m'     
GREEN='\033[0;32m'     
ORANGE='\033[0;33m'     
BLUE='\033[0;34m'     
PURPLE='\033[0;35m'     
CYAN='\033[0;36m'     
LIGHT_GRAY='\033[0;37m'     
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

REPO="git@github.com:ViniciusJO/dotconfigs.git"

# if [[ ! -s /etc/.machine ]]; then
#   quiet printf "\n${PURPLE}Machine name: ${NC} "
#   read -r MACHINE
#   quiet printf "%s\n" "$MACHINE" | sudo tee /etc/.machine &> /dev/null
#   sudo chmod 444 /etc/.machine
# fi

quiet() { (set +x; "$@") }

set -xeo pipefail

# Save logs
[[ -s .init.log ]] && mv .init.log .init.log.old
exec > >(tee -a ".init.log") 2>&1

# Git config
if [[ ! -s ~/.gitconfig ]]; then
  set +x
  quiet printf "\n${YELLOW}Git Credentials${NC}:\n\n=> Name: "
  read -r NAME
  quiet printf "=> Email: "
  read -r EMAIL
  quiet printf "[user]\n    name = %s\n    email = %s\n" "$NAME" "$EMAIL" > $HOME/.gitconfig 
  quiet printf "\n"
  set -x
fi
OLD_URL=$(git remote get-url origin)
git remote remove origin
git remote remove old_url
git remote add origin "$REPO"
git remote add old_url "$OLD_URL"
unset OLD_URL

# Create dirs
# xdg
mkdir -p "$HOME"/{Desktop,Documents,Downloads,Music,Pictures/Screenshots,Public,Templates,Videos,.local,.config}

mkdir -p "$HOME"/.local/{logs,bin,lib,include,builds,thirdparty,share/{bob,fonts}}

mkdir -p "$HOME"/.nchat

mkdir -p "$HOME"/.config/ncspot

# Config limits
sudo sed -i.bak "s/[\n\r]*# End of file/\n@audio\t\t hard\t rtpio\t\t 94\n@audio\t\t hard\t memlock\t unlimited\n$USER\t\t hard\t rtpio\t\t 94\n$USER\t\t hard\t memlock\t unlimited\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/[\n\r]*# End of file/\n@audio;hard;rtpio;94\n@audio;hard;memlock;unlimited\n$USER;hard;rtpio;94\n$USER;hard;memlock;unlimited\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/[\n\r]*# End of file/\n$(echo "@audio;hard;rtpio;94\n@audio;hard;memlock;unlimited\n$USER;hard;rtpio;94\n$USER;hard;memlock;unlimited" | column -s';' -t)\n\n# End of file/" /etc/security/limits.conf
# sudo sed -i.bak "s/\n\n# End of file/\r@audio\t\t hard\t rtpio\t\t 94\r@audio\t\t hard\t memlock\t unlimited\r\r# End of file/" /etc/security/limits.conf

sudo pacman -S --noconfirm --needed --quiet git zsh stow

stow             \
  binaries       \
	bob/           \
	fonts/         \
  gdb/           \
	i3/            \
  kde/           \
	nchat/         \
	ncspot/        \
	nvim/          \
	octave/        \
	picom/         \
	pip/           \
	polybar/       \
	rofi/          \
	scripts/       \
	sound_effects/ \
	tmux/          \
  vlc/           \
	wallpapers/    \
	wezterm/       \
	zsh/           \

# Default wallpaper
echo "$HOME/dotconfigs/wallpapers/.local/share/wallpapers/default.png" > "$HOME"/.background

(grep "$USER" /etc/passwd | awk -F':' '{print $7}' | grep "zsh" > /dev/null) || chsh -s "/usr/bin/zsh" "$USER"

existCommand() { command -v "$1" > /dev/null; }

sudo pacman -Syyu --noconfirm

quiet printf "${YELLOW}installing paru and paruz...$NC\n"
existCommand "paru"		|| ./binaries/.local/loc_bin/paru -Syy paru-bin --noconfirm --needed #(sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru-git.git "$HOME"/.local/builds/paru && cd "$HOME"/.local/builds/paru && makepkg --noconfirm --needed -si && cd - > /dev/null || return)
# quiet printf "${YELLOW}installing paruz...$NC\n"
existCommand "paruz"	|| paru -S paruz --noconfirm --needed # (git clone https://github.com/joehillen/paruz.git "$HOME"/.local/builds/paruz && cd "$HOME"/.local/builds/paruz && sudo make install && cd - > /dev/null || return)
quiet printf "${YELLOW}installing nvm...$NC\n"
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/loc_bin:$HOME/.local/share/bob/nvim-bin:$PATH

# Config pacman & paru
sudo sed -i.bak "s/#BottomUp/BottomUp/" /etc/paru.conf
sudo sed -i.bak "s/#Color/Color/" /etc/pacman.conf
sudo sed -i.bak "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
sudo sed -i.bak -z "s/#\[multilib\]\n*\r*#Include/[multilib]\nInclude/" /etc/pacman.conf

  #"ark ardour bat bob btop calf curl discord dolphin docker docker-compose dragonfly-reverb eza fd feh firefox fzf gcc gdb guitarix gxplugins.lv2 htop i3 kicad kicad-library kicad-library-3d lazygit lolcat lua lua-jsregexp luarocks ly maim make mdcat mesa mesa-demos mesa-utils mupdf nano ncspot numlockx octave okular onlyoffice openssh picom pipewire pipewire-alsa pipewire-autostart pipewire-jack pipewire-pulse pipewire-zeroconf pavucontrol qpwgraph ripgrep rofi screenfetch sox steam thefuck tldr tmux twolame vim wezterm wget wine xclip xorg yabridge yabridgectl yazi zathura zoxide"
  #"brave gxplugins.lv2 lv2-plugins-aur-meta opera opera-ffmpeg-codecs sublime-text-4 systemd-numlockontty visual-studio-code-bin"
quiet printf "${BLUE}installing packages...$NC\n"
# TODO: Fix nvm, bob and npm node/packages and nvim install

REQUIRED_PACMAN_PACKAGES="$(cat "$HOME/dotconfigs/.packages" | tr "\n" " " | sed "s/ *$//")"
REQUIRED_AUR_PACKAGES="$(cat "$HOME/dotconfigs/.packages.aur" | tr "\n" " " | sed "s/ *$//")"
REQUIRED_NPM_PACKAGES="$(cat "$HOME/dotconfigs/.packages.npm" | tr "\n" " " | sed "s/ *$//")"

eval "paru -Syy --noconfirm --needed --quiet $REQUIRED_PACMAN_PACKAGES"
eval "paru -Syy --noconfirm --needed --quiet $REQUIRED_AUR_PACKAGES"

# Config ly
sudo sed -i.bak -z "s/animate = [a-z]*/animate = matrix/" /etc/ly/config.ini
sudo sed -i.bak -z "s/bigclock = [a-z]*/bigclock = en/" /etc/ly/config.ini
sudo sed -i.bak -z "s/numlock = [a-z]*/numlock = true/" /etc/ly/config.ini
sudo systemctl enable ly

[ ! -f "$HOME/.ssh/id_ed25519" ] && ssh-keygen -t ed25519 -q -f "$HOME/.ssh/id_ed25519" -N ""

existCommand "nvm" && nvm install $NODE_VERSION || (quiet printf "${RED}Command nvm not found...${NC}\n")
existCommand "bob" && bob install nightly && bob use nightly || quiet printf "${RED}Command bob not found...${NC}\n"
existCommand "npm" && npm i -g $REQUIRED_NPM_PACKAGES || quiet printf "${RED}Command npm not found...${NC}\n"

# Setup nvim
quiet printf "${ORANGE}--> nvim setup${NC}"
nvim --headless "+Lazy! sync" "+TSUpdateSync" +qa

yes | zsh -ic 'source $HOME/.zshrc'

# User permisions and groups
sudo usermod -aG adm,audio,bin,cups,dbus,disk,docker,floppy,daemon,ftp,games,git,groups,http,input,kmem,kvm,libvirt,libvirt-qemu,lock,mem,network,optical,power,proc,qemu,render,rfkill,audio,scanner,storage,sys,systemd-coredump,systemd-journal,systemd-journal-remote,systemd-network,systemd-oom,systemd-resolve,systemd-timesync,tty,users,uucp,video,wireshark,uuidd,utmp,root,log,avahi "$USER"

paru -Syyu --noconfirm

quiet printf "${GREEN}Automatic steps COMPLETED${NC}: reboot to finish the initialization...\n"

# Setup platformio
#curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules

#libreoffice-extension-writer2latex
