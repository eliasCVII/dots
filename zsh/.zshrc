eval "$(zoxide init zsh)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:~/.local/bin

# Theme
ZSH_THEME="robbyrussell"

# plugins
plugins=(git zsh-autosuggestions)

# Bindings for autosuggestions
bindkey '^ ' autosuggest-accept # set ctrl-space to accept suggestion

source $ZSH/oh-my-zsh.sh

# something for wsl
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

# Set nvim as defaul editor
export EDITOR=nvim

# Aliases
alias v="nvim"
alias l="exa --icons"
alias c="clear"
alias neo="neofetch"

[ -f "/home/elias/.zsh-env" ] && source /home/elias/.zsh-env

setxkbmap -layout us

eval "$(direnv hook zsh)"
