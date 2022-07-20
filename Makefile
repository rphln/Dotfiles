# Stow packages installable with `make <target>`.
PACKAGES := bin fish git jump konsole mpv sublime tmux

install: $(PACKAGES)

uninstall:
	-stow --no-folding --target $(HOME) --delete $(PACKAGES)

$(PACKAGES):
	-stow --no-folding --target $(HOME) --stow $@

.PHONY: uninstall install
.PHONY: $(PACKAGES)
