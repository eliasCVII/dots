DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"
export ZSH_COMPDUMP="$HOME/.zcompdump"

# Optimize compinit
setopt EXTENDED_GLOB
autoload -Uz compinit
if [[ -n "$ZSH_COMPDUMP"(#qN.m-24) ]]; then
  compinit -C -d "$ZSH_COMPDUMP"
else
  compinit -d "$ZSH_COMPDUMP"
fi
unsetopt EXTENDED_GLOB

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:~/.local/bin:~/.cargo/bin:~/.emacs.d/bin

# Theme
ZSH_THEME="agkozak"

# plugins
plugins=(git zsh-autosuggestions)

# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Bindings for autosuggestions
bindkey '^ ' autosuggest-accept # set ctrl-space to accept suggestion

# Shadow compinit to prevent OMZ from running it again
compinit() { :; }
source $ZSH/oh-my-zsh.sh
unfunction compinit

# Set nvim as defaul editor
export EDITOR=nvim

# Aliases
alias v="nvim"
alias l="eza --icons"
alias ll='eza -l --icons'
alias c="clear"
alias neo="neofetch"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(/usr/bin/mise activate zsh)"
