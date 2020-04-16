# Stow packages installable with `make <target>`.
PACKAGES := alacritty bin git mpv nvim quodlibet tmux x zsh

# Tree clone location.
QMK ?= $(HOME)/Projects/qmk_firmware

# Targets {{{

packages: $(PACKAGES)

all: packages nvim-update xdg-user-dirs

# }}}
# Stow {{{

STOW := stow --no-folding --target $(HOME)

$(PACKAGES):
	-$(STOW) --stow $@

uninstall:
	-$(STOW) --delete $(PACKAGES)

# }}}
# Pseudo-packages {{{

nvim-update: nvim
	nvim +PlugUpgrade +PlugUpdate +PlugInstall +"CocInstall -sync" +CocUpdateSync +qall

# QMK {{{

$(QMK):
	git clone --recursive https://github.com/qmk/qmk_firmware.git $(QMK)

qmk: $(QMK)
	stow --no-folding --target $(QMK) --stow _qmk

# }}}
# XDG directories {{{

xdg-user-dirs: ~/.config/user-dirs.conf
	xdg-user-dirs-update --set DESKTOP   $(shell realpath $(HOME)/Desktop)
	xdg-user-dirs-update --set DOCUMENTS $(shell realpath $(HOME)/Documents)
	xdg-user-dirs-update --set DOWNLOAD  $(shell realpath $(HOME)/Downloads)
	xdg-user-dirs-update --set MUSIC     $(shell realpath $(HOME)/Music)
	xdg-user-dirs-update --set PICTURES  $(shell realpath $(HOME)/Pictures)
	xdg-user-dirs-update --set VIDEOS    $(shell realpath $(HOME)/Videos)

# Prevent `user-dirs.dirs` from resetting on startup.
~/.config/user-dirs.conf:
	echo "enabled=False" >> ~/.config/user-dirs.conf

# }}}

# }}}

.PHONY: all nvim-update qmk uninstall xdg-user-dirs $(PACKAGES)

# vim: foldmethod=marker:
