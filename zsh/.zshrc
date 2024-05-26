export BLACK='\033[0;30m'     
export RED='\033[0;31m'     
export GREEN='\033[0;32m'     
export ORANGE='\033[0;33m'     
export BLUE='\033[0;34m'     
export PURPLE='\033[0;35m'     
export CYAN='\033[0;36m'     
export LIGHT_GRAY='\033[0;37m'     
export DARK_GRAY='\033[1;30m'
export LIGHT_RED='\033[1;31m'
export LIGHT_GREEN='\033[1;32m'
export YELLOW='\033[1;33m'
export LIGHT_BLUE='\033[1;34m'
export LIGHT_PURPLE='\033[1;35m'
export LIGHT_CYAN='\033[1;36m'
export WHITE='\033[1;37m'
export NC='\033[0m' # No Color

export PATH=$HOME/bin:/usr/local/bin:$PATH

export BASE_ZSH_CONFIGS=$HOME/.config/zsh

source $BASE_ZSH_CONFIGS/aliases.zsh

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval $(thefuck --alias)

# Completiions
autoload -U compinit && compinit

# Plugins
export ZSH_PLUGINS=$HOME/.local/share/zsh/plugins

export function botstrap_plugin() {
	if [ -z $1 ] || [ -z $2 ]; then
		printf "usage:\n\t${BLUE}botstrap_plugin${NC} [name] [repo-url]\n"	
	else
		ZSH_PLUGIN_DIR=$ZSH_PLUGINS/$1
		if [ ! -d $ZSH_PLUGIN_DIR ]; then
			git clone $2 $ZSH_PLUGIN_DIR
		fi
	fi
}

export function botstrap_omzsh_plugin() {
	if [ -z $1 ]; then
		printf "usage: \n\t${BLUE}botstrap_plugin${NC} \"[name1] [name2] ...\" <dir>\n\t${BLUE}botstrap_plugin${NC} \"[name1],[name2],...\" <dir>\n"
	else
	
		if [ ! -z $2 ]; then OMZ_PLUGIN_INSTALL_DIR=$2
		else OMZ_PLUGIN_INSTALL_DIR=$ZSH_PLUGINS; fi
		
		# echo $1 | tr " " "\n"
		echo $1 | tr "," "\n" | tr " " "\n" | while read -r plugin; do 
			if [ ! -d "$OMZ_PLUGIN_INSTALL_DIR/$plugin" ]; then 
				if [ ! -d "/tmp/omzh" ]; then
					git clone https://github.com/ohmyzsh/ohmyzsh.git /tmp/omzh
				fi
				cp -r /tmp/omzh/plugins/$plugin $OMZ_PLUGIN_INSTALL_DIR/
			fi
		done
	fi

	if [ -d /tmp/omzh ]; then rm -rf /tmp/omzh; fi
}

botstrap_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
botstrap_plugin zsh-completions https://github.com/zsh-users/zsh-completions.git
botstrap_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
botstrap_plugin fzf_tab https://github.com/Aloxaf/fzf-tab

# botstrap_omzsh_plugin "aliases git docker npm pip python pyenv sudo systemd zsh-autosuggestions zsh-syntax-highlighting colored-man-pages command-not-found archlinux"
botstrap_omzsh_plugin "aliases git npm pip python pyenv sudo systemd zsh-autosuggestions zsh-syntax-highlighting colored-man-pages command-not-found archlinux"

find $ZSH_PLUGINS -maxdepth 2 -name "*.zsh" | while read -r plugin; do source $plugin; done

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'if [ -f $realpath ]; then pygmentize -g $realpath; else eza -1 --icons --color $realpath; fi'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '' history-search-forward

# History
HISTSIZE=50000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Tools
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion





#find $ZSH_PLUGINS -maxdepth 2 -name "*.zsh"

# if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
# 	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# fi

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(aliases git docker npm pip python pyenv sudo systemd zsh-autosuggestions zsh-syntax-highlighting zsh-completions colored-man-pages command-not-found archlinux)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
