# Jump around predictably.

declare -Ag bookmarks=(
	[pro]=~/Projects
	[dot]=~/Dotfiles

	[uni]=~/University
	[doc]=~/Documents
	[des]=~/Desktop

	[zsh]=~/Dotfiles/zsh/.config/zsh
	[vim]=~/Dotfiles/nvim/.config/nvim
)

t() {
	cd ${bookmarks[${1}]:-${1}}
}

_t() {
	reply=(${(k)bookmarks})
}

compctl -K _t t
