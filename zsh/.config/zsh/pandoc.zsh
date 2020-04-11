# Preview documents in `man`.

manpd() {
	man --local-file <(pandoc --standalone --to man ${@})
}

manurl() {
	manpd --from html <(curl --silent --location ${@})
}

compdef manpd=pandoc &>/dev/null
compdef manurl=curl &>/dev/null
