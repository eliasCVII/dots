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
alias l="eza --icons"
alias c="clear"
alias neo="neofetch"

[ -f "/home/elias/.zsh-env" ] && source /home/elias/.zsh-env

# setxkbmap -layout us

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -e /home/elias/.nix-profile/etc/profile.d/nix.sh ]; then . /home/elias/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# opam configuration
[[ ! -r /home/elias/.opam/opam-init/init.zsh ]] || source /home/elias/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
