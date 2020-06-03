# Stow packages installable with `make <target>`.
PACKAGES := alacritty fish git mpv nvim quodlibet termux tmux x

# QMK tree target.
QMK ?= $(HOME)/Projects/qmk_firmware

packages: $(PACKAGES)

$(PACKAGES):
	-stow --no-folding --target $(HOME) --stow $@

qmk: $(QMK)
	-stow --no-folding --target $(QMK) --stow _qmk

$(QMK):
	qmk setup --yes --home $(QMK)

.PHONY: $(PACKAGES) packages qmk
