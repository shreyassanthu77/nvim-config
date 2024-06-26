source ~/.config/zsh/utils.zsh
source ~/.config/zsh/zinit.zsh
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/config.zsh

alias r="source ~/.zshrc"

alias z="zellij"
function za() {
	wd=$(pwd)
	if [ "$wd" = "$HOME" ]; then
		base="home"
	else
		base=$(basename $wd)
	fi
	zsessions=$(zellij ls -sn 2> /dev/null)
	if [ -z "$zsessions" ]; then
		zellij -s $base
		return
	fi
	new_session="New Session"
	selected_session=$(echo $new_session'\n'$zsessions | fzf)
	if [ "$selected_session" = "$new_session" ]; then
		zellij -s $base
	else
		zellij attach $selected_session
	fi
	return
}

alias ls="ls --color"
alias l="ls -lah"

alias time="/usr/bin/time"
function md() {
	mkdir -p $@ && cd ${@:$#}
}

alias v="nvim"
alias c="clear"

alias g="git"
alias gl="git log --oneline --decorate --all --graph"
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias lz="lazygit"
function gcp() {
  git add .
	git commit -m "$@"
	git push
}
function gi() {
	curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@
}

# openssl for node js
addlibpath $HOME/.pkgx/openssl.org/v1.1.1w/lib

export GOPATH=$HOME/go
export PNPM_HOME="/home/shreyas/.local/share/pnpm"

export CHROME_EXECUTABLE=$(which microsoft-edge-dev)
PATHS=(
	"$GOPATH/bin"
	"$PNPM_HOME"
	"$HOME/.pulumi/bin"
	"$HOME/.cargo/bin"
	"$HOME/.sst/bin"
	"$HOME/.turso"
	"$HOME/flutter/bin"
	"$HOME/Android/Sdk/platform-tools"
)

for p in $PATHS; do
	addpath $p
done

source <(pkgx --shellcode)
source <(caddy completion zsh)
