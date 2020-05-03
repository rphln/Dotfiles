alias l='ls --classify --color --group-directories-first'
alias ll='l -l --human-readable'

alias open='xdg-open &>/dev/null'

alias v='nvim'
alias m='nvim +"set wrap" +Goyo'

alias gcr='git clone --recursive'
alias grr='git rebase --root --interactive'
alias gs='git status --short'

# Ask for confirmation before making mistakes.
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm -I'
