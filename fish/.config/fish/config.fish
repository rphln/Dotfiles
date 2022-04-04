# Section: Environment

set --export EDITOR subl
set --export VISUAL subl --wait

fish_add_path --prepend ~/.local/bin
fish_add_path --prepend .git/safe/../../bin

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

abbr s rsync --archive --ignore-existing --human-readable --info progress2

abbr v $EDITOR

abbr dl curl --progress-bar --location --remote-name-all

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

# Section: Overrides

set -U fish_features 3.0
set -U fish_greeting

fish_config theme choose None

function ls
    command ls --color --group-directories-first $argv
end

function chpwd --on-variable PWD
    ls
end

set fish_prompt_pwd_dir_length 0

function prompt_pwd_tail --description "Prints the last two path components from `prompt_pwd`."
    string match --regex '(?:^/)?(?:[^/]+/?){0,2}$' (prompt_pwd)
end

function fish_prompt
    printf '%s: ' (prompt_pwd_tail)
end

function fish_right_prompt
    if [ $status = 0 ]
        set_color green
    else
        set_color red
    end

    set -g __fish_git_prompt_showdirtystate yes
    set -g __fish_git_prompt_showstashstate yes
    set -g __fish_git_prompt_showuntrackedfiles yes

    set -g __fish_git_prompt_char_cleanstate ✔
    set -g __fish_git_prompt_char_conflictedstate ✖
    set -g __fish_git_prompt_char_dirtystate ✚
    set -g __fish_git_prompt_char_stagedstate ●
    set -g __fish_git_prompt_char_stashstate ⚑
    set -g __fish_git_prompt_char_untrackedfiles ＊
    set -g __fish_git_prompt_char_upstream_ahead ↓
    set -g __fish_git_prompt_char_upstream_behind ↑

    __fish_git_prompt || echo -n …
    set_color normal
end

function fish_title
    printf '%s — %s' (prompt_pwd_tail) (status current-command)
end
