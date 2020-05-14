set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim

set -a PATH ~/.local/bin/
set -p PATH .git/safe/../../bin

alias l 'ls --classify --color --group-directories-first'
alias ll 'l -l --human-readable'

abbr v 'nvim'
abbr f 'fg &>/dev/null'

abbr cp 'cp --interactive'
abbr mv 'mv --interactive'
abbr rm 'rm --interactive'

abbr md 'mkdir --parents'
abbr rd 'rmdir --parents'

abbr ga 'git add'
abbr gc 'git commit --verbose'
abbr gd 'git diff'
abbr gl 'git pull'
abbr gm 'git merge'
abbr gp 'git push'
abbr gr 'git rebase --interactive'
abbr gs 'git status --short'

abbr gcm 'git checkout master'
abbr gco 'git checkout'

abbr gpf 'git push --force-with-lease'
abbr gp! 'git push --force'

if type -q hub
    alias git 'hub'
end

function chpwd --on-variable PWD
    l
end

function fish_prompt
    printf "%s: " (prompt_pwd)
end
