#!/usr/bin/sh

# on .zshrc:
# [ ! -f $HOME/.local/.started ] && sh "$BASE_ZSH_CONFIGS/apps.zsh" | tee $HOME/.local/logs/app_bootstrap.log

source $HOME/.config/zsh/functions.zsh

REQUIRED_NPM_PACKAGES="neovim pnpm ts-node spottydl typescript yarn" 
REQUIRED_PACMAN_PACKAGES="bob curl eza fd fzf gcc gdb git i3 lua luarocks maim make nano thefuck tmux vim wezterm wget xorg zoxide" #ripgrep 

# From pacman
printf "Installing ${YELLOW}pacman$NC packages...\n"
# FIX: substitutions on parts of the names
mkdir -p $HOME/.local/share/{bob}
# generalPackageBootstrap "sudo pacman -Syy" "$REQUIRED_PACMAN_PACKAGES" "nvim=neovim" #rg=ripgrep" 
sudo pacman -Syy $REQUIRED_PACMAN_PACKAGES

unset REQUIRED_PACMAN_PACKAGES

# From Source
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')
existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git $HOME/.local/builds/paru && cd $HOME/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git $HOME/.local/builds/paruz && cd $HOME/.local/builds/paruz && make install && cd - > /dev/null)

# Install node
existCommand "nvm" && nvm install $NODE_VERSION

# From npm
existCommand "npm" && printf "Installing ${YELLOW}pacman$NC packages...\n" && generalPackageBootstrap "npm i -g" "$REQUIRED_NPM_PACKAGES" "typescript=typescript;@types\/node" "npm list -g | grep" || printf "${RED}Command 'npm' not found$NC\n"

unset REQUIRED_NPM_PACKAGES

# Extra configs
existCommand "nvim" || (existCommand "bob" && bob install latest && bob use latest)

unsetCustomFuncs

touch $HOME/.local/.started

