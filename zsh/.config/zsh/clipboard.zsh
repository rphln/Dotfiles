# Utility wrappers around `clipcopy`.

# Same as `clipcopy`, except it trims trailing line endings.
cb() {
	echo -n "$(</dev/stdin)" | clipcopy "${@}"
}

cbf() {
	cb <"${1}"
}

cbwd() {
	pwd | cb
}
