# Stow packages installable with `make <target>`.
PACKAGES := alacritty bin git mpv nvim quodlibet termux tmux x zsh

# Tree clone location.
QMK ?= $(HOME)/Projects/qmk_firmware

# Stow {{{

STOW := stow --no-folding --target $(HOME)

packages: $(PACKAGES)

uninstall:
	-$(STOW) --delete $(PACKAGES)

$(PACKAGES):
	-$(STOW) --stow $@

# }}}
# Misc {{{

$(QMK):
	git clone --recursive https://github.com/qmk/qmk_firmware.git $(QMK)

qmk: $(QMK)
	stow --no-folding --target $(QMK) --stow _qmk

# }}}

.PHONY: $(PACKAGES) packages qmk uninstall

# vim: foldmethod=marker:
