# Miscellaneous options.

# Allow comments in interactive shells.
setopt interactive_comments

# Make prompt static.
unsetopt prompt_subst

# Report duration for long-running commands.
export REPORTTIME=5

# Shows current directory and its parent.
export PS1="%2~: "
