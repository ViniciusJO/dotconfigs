#!/usr/bin/sh

sudo pacman -S git zsh stow

stow bob/ fonts/ i3/ nchat/ ncspot/ nvim/ octave/ pip/ rofi/ scripts/ sound_effects/ tmux/ wallpapers/ wezterm/ zsh/

chsh -s /usr/bin/zsh

REQUIRED_PACMAN_PACKAGES="ardour bat bob brave calf curl dolphin dragonfly-bin eza fd firefox fzf gcc gdb guitarix gx i3 lazygit lua luarocks ly maim make mesa mesa-demos mesa-utils nano onlyoffice openssh opera pacman pavucontrol pipewire pipewire-alsa pipewire-autostart pipewire-pulse pipewire-zeroconf qpwgraph ripgrep steam sublime-text-4 thefuck tmux vim wezterm wget wine xclip xorg zoxide zoxide"

function existCommand { command -v "$1" > /dev/null; }

existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git $HOME/.local/builds/paru && cd $HOME/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git $HOME/.local/builds/paruz && cd $HOME/.local/builds/paruz && sudo make install && cd - > /dev/null)
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')

eval "paru -Syy $REQUIRED_PACMAN_PACKAGES"

# Install node
existCommand "nvm" && nvm install $NODE_VERSION

existCommand "npm" && npm i -g neovim nodemon pnpm spottydl ts-node typescript yarn || printf "${RED}Command npm not found..."

