# Jump around predictably.

declare -Ag bookmarks=(
	[pro]=~/Projects
	[dot]=~/Dotfiles
	[uni]=~/University
	[docs]=~/Documents
	[desk]=~/Desktop
)

j() {
	cd ${bookmarks[${1}]:-${1}}
}

_j() {
	reply=(${(k)bookmarks})
}

compctl -K _j j
