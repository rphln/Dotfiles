# History configuration.

setopt hist_expire_dups_first
setopt inc_append_history
setopt hist_reduce_blanks

export HISTSIZE=2147483647
export SAVEHIST=${HISTSIZE}

fzf-history-widget() {
	setopt localoptions pipefail

	fc -rl 1 |
		# Dark magic to filter duplicate lines, skipping the first column.
		perl -ane 'print unless $seen{@F[1..$#F]}++' |
		fzf --with-nth 2.. --tiebreak index --query ${LBUFFER:-''} |
		read -r selected _

	zle vi-fetch-history -n ${selected}
	zle reset-prompt
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
