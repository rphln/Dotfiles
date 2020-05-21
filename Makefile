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
	git clone --recursive https://github.com/qmk/qmk_firmware.git $(QMK)

.PHONY: $(PACKAGES) packages qmk
