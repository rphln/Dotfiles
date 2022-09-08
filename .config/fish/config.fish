# Section: Overrides

set -U fish_features 3.0
set -U fish_greeting

fish_config theme choose None

# Section: Abbreviations

abbr - cd -

abbr 1 ../
abbr 2 ../../
abbr 3 ../../../
abbr 4 ../../../../

abbr = qalc

abbr c cp --interactive --recursive
abbr m mv --interactive

abbr l ls
abbr la ls --almost-all

abbr o open
abbr r trash
abbr t touch

abbr s ssh

abbr v $EDITOR

abbr dl curl --progress-bar --location --remote-name-all
abbr rs rsync --archive --partial --progress --human-readable

abbr md mkdir --parents
abbr rd rmdir --parents

abbr se sudo --edit

# Section: Git

abbr g git status --short

abbr ge git merge
abbr gf git fix
abbr gm git mv
abbr gr git rm
abbr gs git show-last
abbr gu git pull
abbr gx git exec

abbr ga git add
abbr gaf git add --force
abbr gap git add --patch

abbr gb git rebase --interactive
abbr gbr git rebase --interactive --root

abbr gc git commit
abbr gci git commit --message '"Initial commit."'
abbr gc! git commit --amend --reset-author

abbr gcr git clone --recursive

abbr gd git diff
abbr gdw git diff --ignore-space-change

abbr gi git init
abbr gig git ignore

abbr gl git history
abbr glo git history origin..HEAD
abbr glg git history --grep

abbr go git switch
abbr gom git switch master

abbr gp git push
abbr gpu git push --set-upstream origin master
abbr gp! git push --force-with-lease

abbr gre git restore
abbr grs git restore --staged

abbr gstp git stash pop
abbr gstu git stash push

alias cfg 'command git --git-dir ~/.cfg --work-tree ~'

# Section: Keybindings

bind \c_ toggle-comment

bind \cx yank-command
bind \cy yank-path

# Section: File manager

function ls
    command ls --color --group-directories-first {$argv}
end

function chpwd --on-variable PWD
    jump record "$PWD" &
    ls
end

# Section: Prompt

function fish_prompt
    if [ $status = 0 ]
        set_color green
    else
        set_color red
    end

    printf '%s: ' (prompt-directory)
    set_color normal
end

function fish_right_prompt
    if set -q SSH_TTY
        printf '%s%s%s' (set_color green) (prompt_hostname) (set_color normal)
    end
end

function fish_title
    printf '%s — %s' (prompt-directory) (status current-command)
end
