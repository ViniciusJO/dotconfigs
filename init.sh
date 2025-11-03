#!/usr/bin/bash
BLACK='\033[0;30m'
RED='\033[0;31m'
RED_BG='\033[41m'
GREEN='\033[0;32m'
GREEN_BG='\033[42m'
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

ERROR_STYLE="${BLACK}${RED_BG}"
SUCC_STYLE="${BLACK}${GREEN_BG}"

REPO="git@github.com:ViniciusJO/dotconfigs.git"

existCommand() { command -v "$1" > /dev/null; }

log_error() { printf "$@"; false; }

# if [[ ! -s /etc/.machine ]]; then
#   set +x; printf "\n${PURPLE}Machine name: ${NC} "; set -x;
#   read -r MACHINE
#   set +x; printf "%s\n" "$MACHINE" | sudo tee /etc/.machine &> /dev/null; set -x;
#   sudo chmod 444 /etc/.machine
# fi

set -eo pipefail

# Save logs
[[ -s .init.log ]] && mv .init.log .init.log.old
exec > >(tee -a ".init.log") 2>&1

# Git config
if [[ ! -s ~/.gitconfig ]]; then
  printf "\n${YELLOW}Git Credentials${NC}:\n\n=> Name: ";
  read -r NAME
  printf "=> Email: ";
  read -r EMAIL
  printf "[user]\n    name = %s\n    email = %s\n" "$NAME" "$EMAIL" > $HOME/.gitconfig;
  printf "\n";
fi
OLD_URL=$(git remote get-url origin)
if git remote | grep -qx "origin"; then git remote remove origin; fi
git remote add origin "$REPO"
if ! git remote | grep -qx "old_url"; then git remote add old_url "$OLD_URL"; fi
unset OLD_URL

# Create dirs
# xdg
mkdir -p "$HOME"/{Desktop,Documents,Downloads,Music,Pictures/Screenshots,Public,Templates,Videos,.local,.config}

mkdir -p "$HOME"/.local/{logs,bin,lib,include,builds,thirdparty,share/{bob,fonts}}

mkdir -p "$HOME"/.nchat

mkdir -p "$HOME"/.config/ncspot

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/loc_bin:$HOME/.local/share/bob/nvim-bin:$PATH

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

# Set zsh as default shell
(grep "$USER" /etc/passwd | awk -F':' '{print $7}' | grep "zsh" > /dev/null) || chsh -s "/usr/bin/zsh" "$USER"

sudo pacman -Syyu --noconfirm

printf "${ORANGE}installing paru and paruz...$NC\n"
existCommand "paru"	 || ./binaries/.local/loc_bin/paru -Syy paru-bin --noconfirm --needed #(sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru-git.git "$HOME"/.local/builds/paru && cd "$HOME"/.local/builds/paru && makepkg --noconfirm --needed -si && cd - > /dev/null || return)
existCommand "paruz" || paru -S paruz --noconfirm --needed # (git clone https://github.com/joehillen/paruz.git "$HOME"/.local/builds/paruz && cd "$HOME"/.local/builds/paruz && sudo make install && cd - > /dev/null || return)

# Config pacman & paru
sudo sed -i.bak "s/#BottomUp/BottomUp/" /etc/paru.conf
sudo sed -i.bak "s/#Color/Color/" /etc/pacman.conf
sudo sed -i.bak "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
sudo sed -i.bak -z "s/#\[multilib\]\n*\r*#Include/[multilib]\nInclude/" /etc/pacman.conf

printf "${ORANGE}installing packages...$NC\n"

REQUIRED_PACMAN_PACKAGES="$(cat "$HOME/dotconfigs/.packages" | tr "\n" " " | sed "s/ *$//")"
REQUIRED_AUR_PACKAGES="$(cat "$HOME/dotconfigs/.packages.aur" | tr "\n" " " | sed "s/ *$//")"
REQUIRED_NPM_PACKAGES="$(cat "$HOME/dotconfigs/.packages.npm" | tr "\n" " " | sed "s/ *$//")"

eval "paru -Syy --noconfirm --needed --quiet $REQUIRED_PACMAN_PACKAGES"
eval "paru -Syy --noconfirm --needed --quiet $REQUIRED_AUR_PACKAGES"

# SSH key
[ ! -f "$HOME/.ssh/id_ed25519" ] && ssh-keygen -t ed25519 -q -f "$HOME/.ssh/id_ed25519" -N ""

# Setup node
set +x; printf "${ORANGE}installing nvm...$NC\n"; set -x;
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -d "$NVM_DIR" ]	|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
existCommand "nvm" || log_error "${ERROR_STYLE} ERROR ${NC}: ${RED}Command nvm not found...${NC}\n" && nvm install $NODE_VERSION && nvm use $NODE_VERSION

# Setup nvim
existCommand "bob" || log_error "${ERROR_STYLE} ERROR ${NC}: ${RED}Command bob not found...${NC}\n" && ! existCommand "nvim" && bob install nightly && bob use nightly
nvim --headless "+Lazy! sync" "+TSUpdateSync" +qa

zsh -ic "source $HOME/.zshrc && command -v \"npm\" > /dev/null && npm i -g $REQUIRED_NPM_PACKAGES" # || printf \"${RED}Command npm not found...${NC}\n\";

# Setup tmux
printf "${ORANGE}--> tmux setup ${NC}\n"
if existCommand "tmux"; then
  tmux start-server
  tmux new-session -d -s setup "
    [[ -s \"$HOME/.tmux/plugins/tpm/bin/install_plugins\" ]] || log_error \"${ERROR_STYLE} ERROR ${NC}: ${RED}TPM not installed...${NC}\n\" && \
      ~/.tmux/plugins/tpm/bin/install_plugins >> .tmux.log && \
      ~/.tmux/plugins/tpm/bin/update_plugins  >> .tmux.log all;
    exit
  "
  tmux wait-for -S 'done'
  cat .tmux.log || true
  rm .tmux.log || true
else
  log_error "${ERROR_STYLE} ERROR ${NC}: ${RED}tmux not found...${NC}"
fi

# User permisions and groups
sudo usermod -aG adm,audio,bin,cups,dbus,disk,docker,floppy,daemon,ftp,games,git,groups,http,input,kmem,kvm,libvirt,libvirt-qemu,lock,mem,network,optical,power,proc,qemu,render,rfkill,audio,scanner,storage,sys,systemd-coredump,systemd-journal,systemd-journal-remote,systemd-network,systemd-oom,systemd-resolve,systemd-timesync,tty,users,uucp,video,wireshark,uuidd,utmp,root,log,avahi "$USER"

paru -Syyu --noconfirm

# Config ly
sudo sed -i.bak -z "s/animation = [a-z]*/animation = matrix/" /etc/ly/config.ini
sudo sed -i.bak -z "s/bigclock = [a-z]*/bigclock = en/" /etc/ly/config.ini
sudo sed -i.bak -z "s/numlock = [a-z]*/numlock = true/" /etc/ly/config.ini
sudo systemctl enable ly

# Config grub
sudo sed -i.bak -z "s/GRUB_TIMEOUT=[0-9]*/GRUB_TIMEOUT=0/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Privilege rules
if [[ ! -S /etc/sudoers.d/50_default ]]; then
  NOPASSWD_ENTITIES=(%whell %sudo root vinicius)
  for entity in "${NOPASSWD_ENTITIES[@]}"; do
    printf "%-15s ALL=(ALL:ALL) NOPASSWD: ALL\n" "$entity" >> .50_default.tmp
  done
  sudo chown root:root .50_default.tmp
  sudo chmod 440 .50_default.tmp
  sudo mv .50_default.tmp /etc/sudoers.d/50_default
fi

# Plymouth
./plymouth/install_theme.sh
./plymouth/install_plymouth.sh

printf "\n\n${SUCC_STYLE} Automatic steps COMPLETED ${NC}: reboot to finish the initialization...\n"

# TODO:
#   - consolefonts

