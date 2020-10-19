# Stow packages installable with `make <target>`.
PACKAGES := alacritty fish git mpv

packages: $(PACKAGES)

$(PACKAGES):
	-stow --no-folding --target $(HOME) --stow $@

.PHONY: $(PACKAGES) packages
