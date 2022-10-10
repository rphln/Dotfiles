#!/usr/bin/env bash

# Section: Options

shopt -s autocd   # Change into a directory by using its bare name.
shopt -s globstar # Enable recursive globs.

shopt -s cmdhist    # Save multi-line commands as one.
shopt -s histappend # Append instead of overwritting.

HISTSIZE=     # Unlimited history storage in the memory.
HISTFILESIZE= # Unlimited history storage in the file.

HISTTIMEFORMAT="%F %T	" # Date and time format for `history`.

HISTCONTROL="erasedups:ignoreboth"                  # Ignore duplicate entries.
HISTIGNORE="&:[ ]*:exit:ls:l:-:bg:fg:history:clear" # Ignore uninteresting commands.

PROMPT_COMMAND+="${PROMPT_COMMAND:+;} history -a" # Flush the history immediately.

# Section: Environment

export PATH="${HOME}/.local/bin${PATH:+:${PATH}}"

if hash subl &>/dev/null; then
	export EDITOR="subl"
	export VISUAL="subl --wait"
fi

# See: <https://github.com/arcticicestudio/nord-dircolors>.
export LS_COLORS="no=00:rs=0:fi=00:di=01;34:ln=36:mh=04;36:pi=04;01;36:so=04;33:do=04;01;36:bd=01;33:cd=33:or=31:mi=01;37;41:ex=01;36:su=01;04;37:sg=01;04;37:ca=01;37:tw=01;37;44:ow=01;04;34:st=04;37;44:*.7z=01;32:*.ace=01;32:*.alz=01;32:*.arc=01;32:*.arj=01;32:*.bz=01;32:*.bz2=01;32:*.cab=01;32:*.cpio=01;32:*.deb=01;32:*.dz=01;32:*.ear=01;32:*.gz=01;32:*.jar=01;32:*.lha=01;32:*.lrz=01;32:*.lz=01;32:*.lz4=01;32:*.lzh=01;32:*.lzma=01;32:*.lzo=01;32:*.rar=01;32:*.rpm=01;32:*.rz=01;32:*.sar=01;32:*.t7z=01;32:*.tar=01;32:*.taz=01;32:*.tbz=01;32:*.tbz2=01;32:*.tgz=01;32:*.tlz=01;32:*.txz=01;32:*.tz=01;32:*.tzo=01;32:*.tzst=01;32:*.war=01;32:*.xz=01;32:*.z=01;32:*.Z=01;32:*.zip=01;32:*.zoo=01;32:*.zst=01;32:*.aac=32:*.au=32:*.flac=32:*.m4a=32:*.mid=32:*.midi=32:*.mka=32:*.mp3=32:*.mpa=32:*.mpeg=32:*.mpg=32:*.ogg=32:*.opus=32:*.ra=32:*.wav=32:*.3des=01;35:*.aes=01;35:*.gpg=01;35:*.pgp=01;35:*.doc=32:*.docx=32:*.dot=32:*.odg=32:*.odp=32:*.ods=32:*.odt=32:*.otg=32:*.otp=32:*.ots=32:*.ott=32:*.pdf=32:*.ppt=32:*.pptx=32:*.xls=32:*.xlsx=32:*.app=01;36:*.bat=01;36:*.btm=01;36:*.cmd=01;36:*.com=01;36:*.exe=01;36:*.ps1=01;36:*.psm1=01;36:*.reg=01;36:*.sh=01;36:*.woff=36:*.woff2=36:*.eot=36:*.otf=36:*.ttf=36:*.jar=36:*.apk=36:*~=02;37:*.bak=02;37:*.BAK=02;37:*.log=02;37:*.log=02;37:*.old=02;37:*.OLD=02;37:*.orig=02;37:*.ORIG=02;37:*.swo=02;37:*.swp=02;37:*.dll=02;37:*.so=02;37:*.o=02;37:*.bmp=32:*.cgm=32:*.dl=32:*.dvi=32:*.emf=32:*.eps=32:*.gif=32:*.jpeg=32:*.jpg=32:*.JPG=32:*.mng=32:*.pbm=32:*.pcx=32:*.pgm=32:*.png=32:*.PNG=32:*.ppm=32:*.pps=32:*.ppsx=32:*.ps=32:*.svg=32:*.svgz=32:*.tga=32:*.tif=32:*.tiff=32:*.xbm=32:*.xcf=32:*.xpm=32:*.xwd=32:*.xwd=32:*.yuv=32:*.anx=32:*.asf=32:*.avi=32:*.axv=32:*.flc=32:*.fli=32:*.flv=32:*.gl=32:*.m2v=32:*.m4v=32:*.mkv=32:*.mov=32:*.MOV=32:*.mp4=32:*.mpeg=32:*.mpg=32:*.nuv=32:*.ogm=32:*.ogv=32:*.ogx=32:*.qt=32:*.rm=32:*.rmvb=32:*.swf=32:*.vob=32:*.webm=32:*.wmv=32:*.cc=32:*.cpp=32:*.cs=32:*.fs=32:*.go=32:*.h=32:*.htm=32:*.html=32:*.java=32:*.js=32:*.jsx=32:*.lua=32:*.m=32:*.pug=32:*.py=32:*.rs=32:*.scala=32:*.swift=32:*.ts=32:*.tsx=32:*.csproj=31:*.vcxproj=31:*.sfproj=31:*.deployproj=31:*.sln=31:*.csv=33:*.json=33:*.md=33:*.nuspec=33:*.txt=33:*.xml=33:*.yaml=33:*.yml=33:*.toml=33:*.css=35:*.scss=35:*.sass=35:*.less=35:"

export LESS_TERMCAP_mb=$'\e[31m' # Begin blinking.
export LESS_TERMCAP_md=$'\e[34m' # Begin bold.
export LESS_TERMCAP_me=$'\e[0m'  # End mode.
export LESS_TERMCAP_se=$'\e[0m'  # End standout-mode.
export LESS_TERMCAP_ue=$'\e[0m'  # End underline.
export LESS_TERMCAP_us=$'\e[32m' # Begin underline.

# Section: Prompt

PS1=$'${SSH_TTY:+\[\e[36m\]\h }\[\e[32m\]$(prompt-directory):\[\e[0m\] '

function prompt-directory {
	dirs +0 |
		grep --perl --only-matching "(?:^/)?(?:[^/]+/?){0,2}$"
}

# Section: Aliases

alias -- -="cd -"

# shellcheck disable=SC2139
alias v='${EDITOR:-vi}'
alias vs="sudo --edit"

alias c="cp --interactive --recursive"
alias m="mv --interactive"

alias md="mkdir --parents"
alias rd="rmdir --parents"

alias l="ls --color --group-directories-first --human-readable"

alias la="l -A"
alias ll="l -l"

alias r="trash"
alias t="touch"

alias s='ssh -o RequestTTY=yes -o RemoteCommand="hash tmux &>/dev/null && tmux new -A -s default || $SHELL"'
alias x="tmux new -A -s default"

alias dl="wget --continue --no-verbose --show-progress"
alias rs="rsync --archive --human-readable --partial --progress"

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

alias cfg="git --git-dir ~/.cfg --work-tree ~"

# Section: Functions

function cd {
	builtin cd "$@" ||
		return
	l
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

function yank {
	cat -- "$@" |
		if [[ -n ${WAYLAND_DISPLAY} ]] && hash wl-copy &>/dev/null; then
			wl-copy
		elif [[ -n ${DISPLAY} ]] && hash xclip &>/dev/null; then
			xclip -selection clipboard
		else
			echo -ne "\e]52;c;$(base64 --wrap 0);\a"
		fi
}

function packages {
	# shellcheck disable=SC2046
	expac --timefmt "%F %T" "%l	%n" $(pacman --query --explicit --quiet) |
		sort
}

function trash {
	if mkdir --parents ~/.local/share/Trash/files ~/.local/share/Trash/info; then
		version="$(date +%s%N)"

		for file; do
			path="$(realpath --no-symlinks "${file}")"

			name="${path##*/}"
			stem="${name%.*}"
			suffix="${name#"${stem}"}"

			destination="${stem}.~${version}~${suffix:-.}"

			if mv -- "${path}" "${HOME}/.local/share/Trash/files/${destination}"; then
				cat <<-EOF >"${HOME}/.local/share/Trash/info/${destination}.trashinfo"
					[Trash Info]
					Path=${path}
					DeletionDate=$(date +%FT%T)
				EOF
			fi
		done
	fi
}
