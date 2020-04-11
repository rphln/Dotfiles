if [[ $EUID == 0 ]]; then
	printf '%s!>%s %s.\n' $(tput setaf 1) $(tput sgr0) "Running as root is disallowed" >&2
	exit 1
fi

autoload -Uz compinit is-at-least

source ~/.profile
source ~/.config/zsh/cobra.zsh

source <(dircolors $(cobra github seebi/dircolors-solarized -w)/dircolors.ansi-dark)

omz=(
	-s lib/clipboard.zsh
	-s lib/completion.zsh
	-s lib/directories.zsh
	-s lib/history.zsh
	-s lib/key-bindings.zsh
	-s lib/termsupport.zsh
	-s lib/theme-and-appearance.zsh
	-l plugins/colored-man-pages
	-l plugins/copybuffer
	-l plugins/cp
	-l plugins/extract
	-l plugins/git
	-l plugins/github
	-l plugins/mix
	-l plugins/pip
)

cobra github robbyrussell/oh-my-zsh ${omz[@]}

cobra github zsh-users/zsh-completions
cobra github zsh-users/zsh-autosuggestions
cobra github zsh-users/zsh-syntax-highlighting

cobra load ~/.config/zsh

() {
	setopt localoptions extendedglob

	if [[ -n ~/.zcompdump.zwc(#qN.mh-24) ]]; then
		compinit -i -C
	else
		compinit -i
		zcompile -M ~/.zcompdump
	fi
}

cobra bite
