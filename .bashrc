#!/usr/bin/env bash

# Section: Options

shopt -s autocd
shopt -s globstar

shopt -s cmdhist
shopt -s histappend

# Section: Environment

export PATH="${HOME}/.local/bin${PATH:+:${PATH}}"

if hash subl &>/dev/null; then
	export EDITOR='subl'
	export VISUAL='subl --wait'
fi

# See: <https://github.com/arcticicestudio/nord-dircolors>.
export LS_COLORS='no=00:rs=0:fi=00:di=01;34:ln=36:mh=04;36:pi=04;01;36:so=04;33:do=04;01;36:bd=01;33:cd=33:or=31:mi=01;37;41:ex=01;36:su=01;04;37:sg=01;04;37:ca=01;37:tw=01;37;44:ow=01;04;34:st=04;37;44:*.7z=01;32:*.ace=01;32:*.alz=01;32:*.arc=01;32:*.arj=01;32:*.bz=01;32:*.bz2=01;32:*.cab=01;32:*.cpio=01;32:*.deb=01;32:*.dz=01;32:*.ear=01;32:*.gz=01;32:*.jar=01;32:*.lha=01;32:*.lrz=01;32:*.lz=01;32:*.lz4=01;32:*.lzh=01;32:*.lzma=01;32:*.lzo=01;32:*.rar=01;32:*.rpm=01;32:*.rz=01;32:*.sar=01;32:*.t7z=01;32:*.tar=01;32:*.taz=01;32:*.tbz=01;32:*.tbz2=01;32:*.tgz=01;32:*.tlz=01;32:*.txz=01;32:*.tz=01;32:*.tzo=01;32:*.tzst=01;32:*.war=01;32:*.xz=01;32:*.z=01;32:*.Z=01;32:*.zip=01;32:*.zoo=01;32:*.zst=01;32:*.aac=32:*.au=32:*.flac=32:*.m4a=32:*.mid=32:*.midi=32:*.mka=32:*.mp3=32:*.mpa=32:*.mpeg=32:*.mpg=32:*.ogg=32:*.opus=32:*.ra=32:*.wav=32:*.3des=01;35:*.aes=01;35:*.gpg=01;35:*.pgp=01;35:*.doc=32:*.docx=32:*.dot=32:*.odg=32:*.odp=32:*.ods=32:*.odt=32:*.otg=32:*.otp=32:*.ots=32:*.ott=32:*.pdf=32:*.ppt=32:*.pptx=32:*.xls=32:*.xlsx=32:*.app=01;36:*.bat=01;36:*.btm=01;36:*.cmd=01;36:*.com=01;36:*.exe=01;36:*.reg=01;36:*~=02;37:*.bak=02;37:*.BAK=02;37:*.log=02;37:*.log=02;37:*.old=02;37:*.OLD=02;37:*.orig=02;37:*.ORIG=02;37:*.swo=02;37:*.swp=02;37:*.bmp=32:*.cgm=32:*.dl=32:*.dvi=32:*.emf=32:*.eps=32:*.gif=32:*.jpeg=32:*.jpg=32:*.JPG=32:*.mng=32:*.pbm=32:*.pcx=32:*.pgm=32:*.png=32:*.PNG=32:*.ppm=32:*.pps=32:*.ppsx=32:*.ps=32:*.svg=32:*.svgz=32:*.tga=32:*.tif=32:*.tiff=32:*.xbm=32:*.xcf=32:*.xpm=32:*.xwd=32:*.xwd=32:*.yuv=32:*.anx=32:*.asf=32:*.avi=32:*.axv=32:*.flc=32:*.fli=32:*.flv=32:*.gl=32:*.m2v=32:*.m4v=32:*.mkv=32:*.mov=32:*.MOV=32:*.mp4=32:*.mpeg=32:*.mpg=32:*.nuv=32:*.ogm=32:*.ogv=32:*.ogx=32:*.qt=32:*.rm=32:*.rmvb=32:*.swf=32:*.vob=32:*.webm=32:*.wmv=32:'

export LESS_TERMCAP_mb=$'\e[31m' # Begin blinking.
export LESS_TERMCAP_md=$'\e[34m' # Begin bold.
export LESS_TERMCAP_me=$'\e[0m'  # End mode.
export LESS_TERMCAP_se=$'\e[0m'  # End standout-mode.
export LESS_TERMCAP_ue=$'\e[0m'  # End underline.
export LESS_TERMCAP_us=$'\e[32m' # Begin underline.

# Section: Prompt

PS1=$'\[\e[32m$(prompt-directory):\e[0m\] '

function prompt-directory {
	dirs +0 | grep --perl --only-matching "(?:^/)?(?:[^/]+/?){0,2}$"
}

# Section: Aliases

# shellcheck disable=SC2139
alias v=${EDITOR:-vi}

alias c="cp --interactive --recursive"
alias m="mv --interactive"

alias md="mkdir --parents"
alias rd="rmdir --parents"

alias l="ls --color --group-directories-first --human-readable"

alias r="trash"
alias t="touch"

alias s="ssh"

alias dl="curl --progress-bar --location --remote-name-all"
alias rs="rsync --archive --partial --progress --human-readable"

alias se="sudo --edit"

# Section: Git

alias g="git status --short"

alias ge="git merge"
alias gf="git fix"
alias gi="git init"
alias gm="git mv"
alias gr="git rm"
alias gs="git show-last"
alias gu="git pull"
alias gx="git exec"

alias ga="git add"
alias gaf="git add --force"
alias gap="git add --patch"

alias gb="git rebase --interactive"
alias gbr="git rebase --interactive --root"

alias gc="git commit"
alias gci="git commit --message 'Initial commit.'"
alias gc!="git commit --amend --reset-author"

alias gcr="git clone --recursive"

alias gd="git diff"
alias gdw="git diff --ignore-space-change"

alias gl="git history"
alias glo="git history origin..HEAD"
alias glg="git history --grep"

alias go="git switch"
alias gom="git switch master"

alias gp="git push"
alias gpu="git push --set-upstream origin master"
alias gp!="git push --force-with-lease"

alias gre="git restore"
alias grs="git restore --staged"

alias gstp="git stash pop"
alias gstu="git stash push"

alias cfg='git --git-dir ~/.cfg --work-tree ~'

# Section: Functions

function cd {
	builtin cd "$@" || return
	l
}

function my-ip {
	dig +short myip.opendns.com @resolver1.opendns.com
}

function my-local-ip {
	ip route get 1.1.1.1 | perl -lne 'print for /src (\K\S+)/'
}

function preview {
	man --local-file <(pandoc --standalone --sandbox --to man "$@")
}

function yank {
	perl -pe 'chomp if eof' -- "$@" |
		if [[ -v WAYLAND_DISPLAY ]] && hash wl-copy &>/dev/null; then
			wl-copy
		elif [[ -v DISPLAY ]] && hash xclip &>/dev/null; then
			xclip -selection clipboard
		else
			base64 --wrap 0 | xargs printf '\e]52;c;%s;\a'
		fi
}

function packages {
	# shellcheck disable=SC2046
	expac --timefmt '%Y-%m-%d' '%l	%n' $(pacman --query --explicit --quiet) | sort
}
