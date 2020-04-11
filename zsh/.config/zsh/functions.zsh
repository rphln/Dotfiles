shit() {
	sudo -- bash -c "$(fc -ln -1)"
	echo 'shit ' $_
}

xip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}

recompile() {
	for file in ${_cobra_sources[@]}; do
		zcompile -M ${file}
	done
}

gitignore() {
	curl -sL "https://gitignore.io/api/${(j:,:)@}" -o .gitignore
}

vw() {
	${EDITOR} -- $(which ${@})
}
