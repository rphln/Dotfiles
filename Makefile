# Stow packages installable with `make <target>`.
PACKAGES := alacritty fish git mpv sublime

packages: $(PACKAGES)

uninstall:
	-stow --no-folding --target $(HOME) --delete $(PACKAGES)

$(PACKAGES):
	-stow --no-folding --target $(HOME) --stow $@

.PHONY: $(PACKAGES) packages uninstall
