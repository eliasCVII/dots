eval "$(zoxide init zsh)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:~/.local/bin:~/.cargo/bin:~/.emacs.d/bin

# Theme
ZSH_THEME="agkozak"

# plugins
plugins=(git zsh-autosuggestions)

# Bindings for autosuggestions
bindkey '^ ' autosuggest-accept # set ctrl-space to accept suggestion

source $ZSH/oh-my-zsh.sh

# something for wsl
# export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

# Set nvim as defaul editor
export EDITOR=nvim

# Aliases
alias v="nvim"
alias l="eza --icons"
alias ll='eza -l --icons'
alias c="clear"
alias neo="neofetch"

[ -f "/home/elias/.zsh-env" ] && source /home/elias/.zsh-env


eval "$(direnv hook zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

