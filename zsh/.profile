source "${PREFIX:-/}/etc/profile"

export PATH="${PATH:+${PATH}:}${HOME}/.local/bin"

export VISUAL=nvim
export EDITOR=${VISUAL}

# Use native file pickers.
export GTK_USE_PORTAL=1

# Persist history in `iex`.
export ERL_AFLAGS="-kernel shell_history enabled"
