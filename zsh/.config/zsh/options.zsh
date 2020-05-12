# Allow comments in interactive shells.
setopt interactive_comments

# Make the prompt static.
unsetopt prompt_subst

# Show the current directory and its parent.
export PS1="%2~: "
