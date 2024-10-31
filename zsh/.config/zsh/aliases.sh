
alias zshconfig="editDir $HOME/dotconfigs/zsh"
alias nvimconfig="editDir $HOME/.config/nvim"
alias dotconfig="editDir $HOME/dotconfigs"
alias reload="source $HOME/.zshrc"

alias get_idf='. $HOME/esp/esp-idf/export.sh'
alias get_pio='export PATH=$HOME/.platformio/penv/bin:$PATH'

alias xcopy="xclip -selection clipboard"
alias xpaste="xclip -selection clipboard -o"

alias weather="curl \"wttr.in/Ouro+Branco+MG?0\""
alias weather_full="curl wttr.in/Ouro+Branco+MG"

alias ls="exa --icons"
alias lt="ls --tree"
alias ll="ls -l -g"
alias llt="lt -lg"
alias ls1="ls -1"
alias la="ls -a"
alias lat="la --tree"
alias la1="la -1"
alias lla="ll -a"
alias llat="ls -la --tree"

alias gitl="git log --oneline --graph --all --decorate"
alias gits="git status"

alias t="todo.sh"
alias ta="todo.sh add"
alias tls="todo.sh list"
alias td="todo.sh done"

alias nr="node --run"

alias ..="cd .."
