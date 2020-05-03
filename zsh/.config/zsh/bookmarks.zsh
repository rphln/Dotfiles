# Jump around predictably.

declare -Ag bookmarks=(
	[pro]=~/Projects
	[dot]=~/Dotfiles
	[uni]=~/University
	[docs]=~/Documents
	[desk]=~/Desktop
)

t() {
	cd ${bookmarks[${1}]:-${1}}
}

_t() {
	reply=(${(k)bookmarks})
}

compctl -K _t t
