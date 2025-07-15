if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/tu/.dotnet/tools"
source ~/.config/zsh/fzf.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git web-search z vi-mode zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#eval $(thefuck --alias)
alias sumake="sudo make clean install"
alias rmconfig="sudo rm -rf config.h"
alias allmake="rmconfig && sumake"
alias cdst="cd /home/tu/Suckless/st"
alias cdwm="cd /home/tu/Suckless/dwm"
alias gt="lazygit"
alias c=clear
alias v="nvim"
alias vd="neovide"
alias l='eza --icons=auto' # long list
alias ls='eza --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias rm='rm -rf'
alias shimmervpn="$HOME/landlogin.exp"

export OPENCV_LOG_LEVEL=ERROR
eval "$(mcfly init zsh)"
eval "$(zoxide init zsh --cmd cd)"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
