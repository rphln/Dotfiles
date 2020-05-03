# Jump around predictably.

declare -Ag bookmarks=(
	[pro]=~/Projects
	[dot]=~/Dotfiles

	[uni]=~/University
	[doc]=~/Documents
	[des]=~/Desktop

	[zsh]=~/Dotfiles/zsh/.config/zsh
	[vim]=~/Dotfiles/nvim/.config/nvim

	[qmk]=~/Projects/qmk_firmware/keyboards/atreis/keymaps/rphln
)

t() {
	cd ${bookmarks[${1}]:-${1}}
}

_t() {
	reply=(${(k)bookmarks})
}

compctl -K _t t
