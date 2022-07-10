# Section: Overrides

set -U fish_features 3.0
set -U fish_greeting

fish_config theme choose None

# Section: Environment

set --export EDITOR subl
set --export VISUAL subl --wait

set --universal --prepend fish_user_paths ~/.local/bin
set --universal --prepend fish_user_paths '.git/safe/../../bin'

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

abbr sr systemd-run --user --pty --property MemoryHigh=2G

abbr md mkdir --parents
abbr rd rmdir --parents

abbr se sudo --edit

abbr yf yank-file
abbr yp yank-path

abbr py ipython3

# Section: Git

abbr g git

abbr ge git merge
abbr gf git fix
abbr gm git mv
abbr gr git rm
abbr gs git status --short
abbr gu git pull
abbr gx git exec

abbr ga git add
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

# Section: Keybindings

bind \c_ toggle-comment
bind \cy yank-command

# Section: File manager

function chpwd --on-variable PWD
    ls
end

# Section: Prompt

function fish_prompt
    if set -q SSH_TTY
        printf '%s%s ' (set_color green) (prompt_hostname)
    end

    printf '%s%s: ' (set_color normal) (prompt-directory)
end


function fish_title
    printf '%s — %s' (prompt-directory) (status current-command)
end

# Section: Exit status

function report_command_duration --on-event fish_postexec
    if [ $CMD_DURATION -ge 60000 ]
        set --local s (math --scale 0 $CMD_DURATION / 1000 % 60)
        set --local m (math --scale 0 $CMD_DURATION / 60000 % 60)
        set --local h (math --scale 0 $CMD_DURATION / 3600000)

        printf >&2 "%s‼️%s The previous command took %02d:%02d:%02d.\n" (set_color --bold yellow) (set_color normal) $h $m $s
    end
end

function report_last_error --on-event fish_postexec
    set --local last_status $status
    if [ $last_status != 0 ]
        printf >&2 "%s✘%s The previous command exited with the status code `%d`.\n" (set_color --bold red) (set_color normal) $last_status
    end
end
