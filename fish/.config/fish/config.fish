set fish_greeting

set -U fish_features '3.0'

set -x EDITOR nvim
set -x VISUAL nvim

abbr v $EDITOR

abbr - 'cd -'
abbr l 'ls --group-directories-first'

abbr cp 'cp -i'
abbr mv 'mv -i'
abbr rm 'rm -I'

abbr md 'mkdir --parents'
abbr rd 'rmdir --parents'

abbr gd 'git diff'
abbr gl 'git pull'
abbr gm 'git merge'
abbr gr 'git restore'
abbr gs 'git status --short'

abbr ga 'git add'
abbr gap 'git add --patch'

abbr gc 'git commit'
abbr gc! 'git commit --amend --reset-author'

abbr gcr 'git clone --recursive'

abbr gcm 'git checkout master'
abbr gco 'git checkout'

abbr grb 'git rebase --interactive'
abbr grr 'git rebase --interactive --root'

abbr gsa 'git submodule add'
abbr gsm 'git submodule'

abbr gp 'git push'
abbr gp! 'git push --force'
abbr gpf 'git push --force-with-lease'

abbr gh 'git history'
abbr ghg 'git history --grep'
abbr gho 'git history origin..HEAD'

abbr ... '../..'
abbr .... '../../..'
abbr ..... '../../../..'

if type -q hub
    alias git 'hub'
end

function chpwd --on-variable PWD
    ls --group-directories-first
end

set fish_prompt_pwd_dir_length 0

function prompt_pwd_tail --description "Prints the last two path components from `prompt_pwd`."
    string match -r '(?:^/)?(?:[^/]+/?){0,2}$' (prompt_pwd)
end

function fish_prompt
    printf "%s: " (prompt_pwd_tail)
end

function fish_title
    printf "%s — %s" (prompt_pwd_tail) (status current-command)
end
