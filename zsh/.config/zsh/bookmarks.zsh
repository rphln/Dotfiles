# Jump around.

-do-fzf-bookmarks() {
	setopt localoptions pipefail

	local search_paths=(
		~
		~/Desktop
		~/Documents
		~/Dotfiles
		~/Projects
		~/University
	)

	local fd_opts=(
		--absolute-path
		--max-depth 2
		--type directory
	)

	local fzf_opts=(
		--cycle
		--preview "tree -L 1 --dirsfirst -- {}"
	)

	fd . ${fd_opts[@]} ${search_paths[@]} | awk '!seen[$0]++' | fzf ${fzf_opts[@]}
}

fzf-bookmarks() {
	local target=$(-do-fzf-bookmarks)

	if [[ ! -z ${target} ]]; then
		echo

		cd "${target}"
		zle reset-prompt
	fi
}

zle -N fzf-bookmarks
bindkey '^G' fzf-bookmarks
