  export BASE_ZSH_CONFIGS=$HOME/.config/zsh
  export BASE_ZSH_SHARE=$HOME/.local/share/zsh

  export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/loc_bin:$HOME/.local/share/bob/nvim-bin:$PATH
  export C_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
  export CPLUS_INCLUDE_PATH=$HOME/.local/include:$CPLUS_INCLUDE_PATH
  export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
  export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH

  export FPATH=$BASE_ZSH_SHARE/completions:$FPATH
  export MANPATH="/usr/local/man:$HOME/.local/share/man:$MANPATH"
  export MANPAGER="nvim +Man!"

  export NODE_VERSION="24.4.1"

  # Tools
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  source "$BASE_ZSH_CONFIGS/aliases.sh"
  source "$BASE_ZSH_CONFIGS/colors.sh"
  source "$BASE_ZSH_CONFIGS/functions.sh"

  # General configs
  # Preferred editor for local and remote sessions
  export EDITOR=$(
    ( existCommand "nvim" && echo "nvim" ) || \
    ( existCommand "vim" && echo "vim" ) || \
    ( existCommand "nano" && echo "nano" )
  )

  # Evals
  existCommand "starship" || (curl -sS https://starship.rs/install.sh | sh -s -- --yes) && eval "$(starship init zsh)"
  existCommand "zoxide"   && eval "$(zoxide init zsh)"
  existCommand "fzf"			&& eval "$(fzf --zsh)"
  existCommand "fuck"			&& eval "$(thefuck --alias)"

  ## Completiions
  # bob
  [ ! -f $HOME/.local/share/zsh/completions/_bob ] && \
    mkdir -p $HOME/.local/share/zsh/completions && \
    bob complete zsh > $HOME/.local/share/zsh/completions/_bob
  autoload -U compinit && compinit

  # Plugins
  export ZSH_PLUGINS=$HOME/.local/share/zsh/plugins

  botstrap_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
  botstrap_plugin zsh-completions https://github.com/zsh-users/zsh-completions.git
  botstrap_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
  botstrap_plugin fzf_tab https://github.com/Aloxaf/fzf-tab
  botstrap_plugin you_should_use https://github.com/MichaelAquilina/zsh-you-should-use.git

  botstrap_omzsh_plugin "aliases git npm pip python pyenv sudo systemd zsh-autosuggestions zsh-syntax-highlighting colored-man-pages command-not-found archlinux"
  # botstrap_omzsh_plugin "aliases git docker npm pip python pyenv sudo systemd zsh-autosuggestions zsh-syntax-highlighting colored-man-pages command-not-found archlinux"

  find $ZSH_PLUGINS -maxdepth 2 -name "*.zsh" | while read -r plugin; do source $plugin; done

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'if [ -f $realpath ]; then pygmentize -g $realpath; else eza -1 --icons --color $realpath; fi'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Special Keybindings
bindkey "^[[H"  beginning-of-line				# END
bindkey	"^[[1~"	beginning-of-line				# END
bindkey "^[[F"  end-of-line							# HOME
bindkey	"^[[4~"	end-of-line							# HOME
bindkey "^[[3~" delete-char							# DEL
bindkey "^[[1;5C" forward-word					# CTRL + RIGHT
bindkey "^[[1;5D" backward-word					# CTRL + LEFT
#		History Keybindings
bindkey '^[[A' history-search-backward	# UP
bindkey '' history-search-backward		# CTRL + P
bindkey '^[[B' history-search-forward		# DOWN
bindkey '' history-search-forward			# CTRL + N

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

unsetCustomFuncs

ulimit -l unlimited

# weather

export QT_QPA_PLATFORMTHEME="qt6ct"
export QT_STYLE_OVERRIDE="qt6ct"
















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

