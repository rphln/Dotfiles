#!/usr/bin/env bash

# Section: Environment

export LC_ALL="en_GB.UTF-8"
unset LANG LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION

: "${SSH_AUTH_SOCK:="${XDG_RUNTIME_DIR}/ssh-agent.socket"}"
export SSH_AUTH_SOCK

# shellcheck disable=SC2076
if ! [[ ":${PATH}:" =~ ":${HOME}/.local/bin:" ]]; then
	export PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
fi

# shellcheck disable=SC2076
if ! [[ ":${PATH}:" =~ ":${HOME}/.local/lib/miniforge3/bin:" ]]; then
	export PATH="${HOME}/.local/lib/miniforge3/bin${PATH:+:${PATH}}"
fi

# shellcheck disable=SC2076
if ! [[ ":${PATH}:" =~ ":${HOME}/.cargo/bin:" ]]; then
	export PATH="${HOME}/.cargo/bin${PATH:+:${PATH}}"
fi

if hash code &>/dev/null; then
	export EDITOR="code"
	export VISUAL="code --wait"
else
	export EDITOR="vi"
	export VISUAL="vi"
fi

# Host-specific overrides.
if [[ -r ~/.bashrc.local ]]; then
	# shellcheck disable=SC1090
	source ~/.bashrc.local
fi

# Commands after this point are only executed in interactive shells.
#
# See <https://meta.ath0.com/2007/10/23/cleaning-up-bash-customizations/>.
if ! [[ $- =~ i ]]; then
	return
fi

# Section: Options

shopt -s autocd   # Change into a directory by using its bare name.
shopt -s globstar # Enable recursive globs.

# See `~/.local/share/bash-completion/completions` for lazy loading of completions.
if [[ -f /etc/bash_completion ]]; then
	source /etc/bash_completion
elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
	source /usr/share/bash-completion/bash_completion
fi

# Section: History

shopt -s cmdhist    # Save multi-line commands as one.
shopt -s histappend # Append instead of overwritting.

# Records everything in the history.
HISTCONTROL=
HISTIGNORE=

# Removes the limit on the number of commands in the history, both in memory and in the
# file, respectively.
HISTSIZE=
HISTFILESIZE=

# Records the execution time of each command in the history file when set. Then, uses
# the specified time format for `history`.
HISTTIMEFORMAT="%F %T  "

# An unconfigured Bash instance may truncate the default history file when opened. We
# can prevent such accidents by moving it elsewhere.
#
# See <https://news.ycombinator.com/item?id=33187749>.
if mkdir --parents ~/.local/state/bash; then
	HISTFILE=~/.local/state/bash/history
fi

# Flushes the history after every command. This ensures that new Bash instances read an
# up-to-date history.
#
# Previously, this also had either `history -n` or `history -c; history -r` to share
# the history across live instances, but that was a tad confusing.
#
# See <https://unix.stackexchange.com/a/18443>.
PROMPT_COMMAND+="${PROMPT_COMMAND:+;} history -a"

# Section: Appearance

function prompt-directory {
	grep --perl --only-matching "(?:^/)?(?:[^/]+/?){0,2}$" <<<"${PWD/#${HOME}/'~'}"
}

# We need to export `PS1`: some programs, such as `conda`, break otherwise.
export PS1=$'\[\e[34m\]${SSH_TTY:+\h }$(prompt-directory):\[\e[0m\] '

# See <https://github.com/seebi/dircolors-solarized>.
export LS_COLORS='no=00:fi=00:di=36:ow=34;47:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32:*.vh=32:*.vhd=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.nef=33:*.NEF=33:*.webp=33:*.heic=33:*.HEIC=33:*.avif=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.pdf=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.zst=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;34:*~=01;34:*#=01;34:*.bak=01;36:*.BAK=01;36:*.old=01;36:*.OLD=01;36:*.org_archive=01;36:*.off=01;36:*.OFF=01;36:*.dist=01;36:*.DIST=01;36:*.orig=01;36:*.ORIG=01;36:*.swp=01;36:*.swo=01;36:*.v=01;36:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'

export LESS_TERMCAP_mb=$'\e[31m' # Begin blinking.
export LESS_TERMCAP_md=$'\e[34m' # Begin bold.
export LESS_TERMCAP_me=$'\e[0m'  # End mode.
export LESS_TERMCAP_se=$'\e[0m'  # End highlight.
export LESS_TERMCAP_so=$'\e[7m'  # Begin highlight.
export LESS_TERMCAP_ue=$'\e[0m'  # End underline.
export LESS_TERMCAP_us=$'\e[32m' # Begin underline.

# Section: Aliases

alias -- -="cd -"

alias v='${EDITOR:-vi}'
alias vs="sudo --edit"

alias c="cp --interactive --recursive"
alias m="mv --interactive"

alias md="mkdir --parents"
alias rd="rmdir --parents"

alias l="ls --color --group-directories-first --human-readable"
alias la="l -A"
alias ll="l -l"
alias lla="l -lA"

alias t="tmux new -A -s default"
alias s="ssh -o RequestTTY=yes -o RemoteCommand='tmux new -A -s default'"

alias h='env HTOPRC=~/.config/htop/minrc htop --user ${USER}'

alias dl="wget --continue --no-verbose --show-progress"
alias rs="rsync --archive --human-readable --partial --progress"

# Section: Git

alias g="git status --short"

alias ga="git add"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gr="git restore"
alias gu="git pull"

alias gcl="git clone --recursive"
alias gco="git commit"

alias cfg="git --git-dir ~/.cfg --work-tree ~"

# Section: Functions

function cd {
	builtin cd "$@" &&
		l
}

function bookmark {
	command=$(printf 'alias @%q="cd %q"\n' "${1}" "${2:-${PWD}}")

	eval "${command}" &&
		echo "${command}" >>~/.bashrc.local
}

function my-ip {
	dig +short myip.opendns.com @resolver1.opendns.com
}

function my-local-ip {
	ip route get 1.1.1.1 |
		grep --perl --only-matching "src (\K\S+)"
}

function preview {
	pandoc --standalone --sandbox --to man "$@" |
		man --local-file -
}

# shellcheck disable=SC2120
function yank {
	printf "\e]52;c;"
	cat -- "${@}" | base64
	printf "\a"
}

function yank-command-line {
	yank <<<"${READLINE_LINE}"
}

bind -x '"\C-y": yank-command-line'

# Section: Laziness

# Performs lazy initialization through hot-swap stubs. These tools are particularly slow
# to setup; being lazy considerably improves the shell start-up time.
#
# See <https://dev.to/zanehannanau/bash-lazy-completion-evaluation-2a2d>.

if hash conda &>/dev/null; then
	function conda {
		unset -f conda

		# shellcheck disable=SC1090
		source <(conda shell.bash hook)
		conda "${@}"
	}
fi
