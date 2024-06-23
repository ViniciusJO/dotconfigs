#!/usr/bin/sh

REPO="git@github.com:ViniciusJO/dotconfigs.git"

git remote remove origin
git remote add origin "$REPO"

sudo pacman -S --noconfirm --needed --quiet git zsh stow

stow bob/ fonts/ i3/ nchat/ ncspot/ nvim/ octave/ pip/ rofi/ scripts/ sound_effects/ tmux/ wallpapers/ wezterm/ zsh/

(cat /etc/passwd | grep "$USER" | awk -F':' '{print $7}' | grep "zsh" > /dev/null) || chsh -s "/usr/bin/zsh" "$USER"

REQUIRED_PACMAN_PACKAGES="ardour bat bob brave calf curl dolphin dragonfly-bin eza fd feh firefox fzf gcc gdb guitarix i3 lazygit lua luarocks ly maim make mesa mesa-demos mesa-utils nano numlockx onlyoffice openssh opera pacman pavucontrol pipewire pipewire-alsa pipewire-autostart pipewire-pulse pipewire-zeroconf qpwgraph ripgrep rofi steam sublime-text-4 thefuck tmux vim wezterm wget wine xclip xorg zoxide zoxide"

function existCommand { command -v "$1" > /dev/null; }

existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git $HOME/.local/builds/paru && cd $HOME/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git $HOME/.local/builds/paruz && cd $HOME/.local/builds/paruz && sudo make install && cd - > /dev/null)
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')

eval "paru -Syy --noconfirm --needed --quiet $REQUIRED_PACMAN_PACKAGES"

# Create dirs
mkdir -p $HOME/.local/{logs,share/bob}

sudo systemctl enable ly
[ ! -f "$HOME/.ssh/id_ed25519" ] && ssh-keygen -t ed25519 -q -f "$HOME/.ssh/id_ed25519" -N ""

zsh -ic "
	existCommand \"nvm\" && nvm install $NODE_VERSION
	existCommand \"npm\" && npm i -g neovim nodemon pnpm spottydl ts-node typescript yarn || printf \"${RED}Command npm not found...\"
	existCommand \"bob\" && bob install latest && bob use latest || printf \"${RED}Command bob not found...\"
"

unset REPO
