#!/usr/bin/sh

REQUIRED_NPM_PACKAGES="neovim pnpm ts-node spottydl typescript yarn" 
REQUIRED_PACMAN_PACKAGES="bob curl eza fd fzf gcc gdb git i3 lua luarocks maim make nano rg thefuck vim wezterm wget xorg zoxide"

# From pacman
generalPackageBootstrap "sudo pacman -Syyu" "$REQUIRED_PACMAN_PACKAGES" "nvim=neovim rg=ripgrep" 

# Install node
existCommand "bob" && bob install latest

# From npm
existCommand "npm" && generalPackageBootstrap "npm i -g" "$REQUIRED_NPM_PACKAGES" "typescript=typescript;@types\/node" "npm list -g | grep" || printf "${RED}Command 'npm' not found$NC\n"

unset REQUIRED_NPM_PACKAGES
unset REQUIRED_PACMAN_PACKAGES

# From Source
existCommand "nvm"		|| (PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash')
existCommand "paru"		|| (sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git $HOME/.local/builds/paru && cd $HOME/.local/builds/paru && makepkg -si && cd - > /dev/null)
existCommand "paruz"	|| (git clone https://github.com/joehillen/paruz.git $HOME/.local/builds/paruz && cd $HOME/.local/builds/paruz && make install && cd - > /dev/null)

# Extra configs
existCommand "nvim" || (existCommand "bob" && bob install latest && bob use latest)

touch $HOME/.local/.started

