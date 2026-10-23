#!/usr/bin/env zsh

# ~/.config/zsh/theme.zsh

typeset -gA ZSH_HIGHLIGHT_STYLES

# Commands — primary colors
ZSH_HIGHLIGHT_STYLES[command]='fg=%%p1,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=%%p1'
ZSH_HIGHLIGHT_STYLES[function]='fg=%%p2'
ZSH_HIGHLIGHT_STYLES[alias]='fg=%%p2,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=%%p1,underline'

# Arguments and strings — complementary colors
ZSH_HIGHLIGHT_STYLES[default]='fg=%%c2'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=%%c1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=%%c1'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=%%c2'

# Errors and operators
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=%%c3,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=%%p3'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=%%c2'
ZSH_HIGHLIGHT_STYLES[comment]='fg=%%c2'

# Paths and expansions
ZSH_HIGHLIGHT_STYLES[path]='fg=%%p2,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=%%c2'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=%%c4'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=%%p3'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=%%p3'






# # ~/.config/zsh/theme.zsh
# typeset -gA ZSH_HIGHLIGHT_STYLES
#
# # Commands
# ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa,bold'
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'
# ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'
# ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'
# ZSH_HIGHLIGHT_STYLES[precommand]='fg=#89b4fa,underline'
#
# # Arguments and values
# ZSH_HIGHLIGHT_STYLES[default]='fg=#cdd6f4'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
#
# # Errors and operators
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
# ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f9e2af'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#6c7086'
# ZSH_HIGHLIGHT_STYLES[comment]='fg=#6c7086,italic'
#
# # Paths and expansions
# ZSH_HIGHLIGHT_STYLES[path]='fg=#89b4fa,underline'
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=#f9e2af'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#f9e2af'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#cdd6f4'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#cdd6f4'

