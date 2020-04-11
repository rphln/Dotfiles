ctrl-z() {
	fg &>/dev/null
	zle redisplay
}

zle -N ctrl-z
bindkey '^Z' ctrl-z
