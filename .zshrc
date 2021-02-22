typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)

if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
	[[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
	alias x64='exec arch -x86_64 /bin/zsh'
	alias a64='exec arch -arm64e /bin/zsh'
	switch-arch() {
		if  [[ "$(uname -m)" == arm64 ]]; then
			arch=x86_64
		elif [[ "$(uname -m)" == x86_64 ]]; then
			arch=arm64e
		fi
		exec arch -arch $arch /bin/zsh
	}
fi

setopt magic_equal_subst

export HOMEBREW_BUNDLE_NO_LOCK=true

alias h='history'
alias ll='ls -l'
alias la='ls -Al'
alias rm='rm -i'
alias today='date +%Y/%m/%d'
alias todayd='date +%Y%m%d'
alias now='date +%Y/%m/%d-%T'
alias nowd='date +%Y%m%d%H%M%S'
