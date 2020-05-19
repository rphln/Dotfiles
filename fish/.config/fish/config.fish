set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim

set -a PATH ~/.local/bin/
set -p PATH .git/safe/../../bin

alias l 'ls --classify --color --group-directories-first'
alias ll 'l -l --human-readable'

abbr v 'nvim'
abbr f 'fg &>/dev/null'

abbr cp 'cp -i'
abbr mv 'mv -i'
abbr rm 'rm -I'

abbr md 'mkdir --parents'
abbr rd 'rmdir --parents'

abbr gd 'git diff'
abbr gl 'git pull'
abbr gm 'git merge'
abbr gr 'git rebase --interactive'
abbr gs 'git status --short'

abbr ga 'git add'
abbr gap 'git add --patch'

abbr gc 'git commit --verbose'
abbr gc! 'git commit --verbose --amend --reset-author'

abbr gcr 'git clone --recursive'

abbr gcm 'git checkout master'
abbr gco 'git checkout'

abbr gp 'git push'
abbr gp! 'git push --force'
abbr gpf 'git push --force-with-lease'

abbr ... '../..'
abbr .... '../../..'
abbr ..... '../../../..'

if type -q hub
    alias git 'hub'
end

function chpwd --on-variable PWD
    l
end

set fish_prompt_pwd_dir_length 0

function fish_prompt
    printf "%s: " (prompt_pwd)
end

function fish_title
    printf "%s — %s" (prompt_pwd) (status current-command)
end
