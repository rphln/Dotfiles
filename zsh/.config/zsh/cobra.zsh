# A tiny and simple plugin manager for zsh.
#
# It started out as a toy project to see if I could replicate what Antibody was doing,
# and is now what I use to manage my zsh configuration. At the time of writing, this
# script provides the minimal functionality to cover my use case -- automatically
# cloning repositories, updating the `fpath` and sourcing relevant files.
#
# While some new features might be up for inclusion, being a full-blown replacement for
# more complex plugin managers is a non-goal. Features such as new plugin sources are
# probably good candidates, while others such as lazy loading definitely are not.
#
# With all that out of the way, about the code: it's some 150 or so lines of hopefully
# clean zsh code, but I can't say for sure since I'm not particularly experienced in
# writing shell scripts. It is formatted with `shfmt`, but some lines might need to be
# commented before formatting due to presence of zsh-specific features.
#
# Cobra depends on `git` if you want to automatically clone repositories.
#
# This is free and unencumbered software released into the public domain. For more
# information, please refer to <http://unlicense.org/>.

# Directory to clone Git repositories into.
declare cobra_cache=~/.cache/cobra

# Format to use for logs; must contain a single `%s`, for the contents.
declare cobra_info_format='\033[32m=>\033[0m %s'
declare cobra_error_format='\033[31m!>\033[0m %s'
declare cobra_debug_format='\033[33m?>\033[0m %s'

# Git repositories.
declare -Ua _cobra_remotes

# Files to source later.
declare -Ua _cobra_sources

# File formats to try to source, in order.
declare -Ua _cobra_glob_patterns=(
	'*.plugin.zsh'
	'*.zsh'
)

## Logging

# Outputs a log message to `stderr`.
#
# Each supplied argument will be treated as an individual error message in the output.
-cobra-info() {
	printf "${cobra_info_format}\n" ${@} >&2
}

# Outputs an error message to `stderr`.
#
# See `-cobra-info` for more information.
-cobra-error() {
	printf "${cobra_error_format}\n" ${@} "Trace: ${funcfiletrace}" >&2
}

# Outputs a debug message to `stderr`.
#
# See `-cobra-info` for more information; additionally, if the `COBRA_DEBUG` environment
# variable is not set, this function does nothing.
-cobra-debug() {
	if [[ ! -z ${COBRA_DEBUG} ]]; then
		printf "${cobra_debug_format}\n" ${@} >&2
	fi
}

## Utility functions

-cobra-clean-path() {
	tr -c '[:alnum:]' '-' <<<${@}
}

-cobra-dump-path() {
	echo "${cobra_cache}/$(-cobra-clean-path ${1})"
}

-cobra-clone() {
	-cobra-info "Updating: ${1}"

	local target=$(-cobra-dump-path ${1})

	(if cd ${target} &>/dev/null; then
		git pull --force
	else
		git clone --recursive ${1} ${target}
	fi)

	if [[ $? != 0 ]]; then
		-cobra-error "Failed to update: ${1}"
		return 1
	fi

	-cobra-debug "Updated: ${1}"
}

## Public interface

# Loads the specified GitHub repository as a plugin.
#
# Usage
#   cobra-github <repository> [(-l <folder>)...] [(-s <file>)...]
#
cobra-github() {
	# Prevents prompts when cloning private or invalid repositories.
	cobra-git "https://git::@github.com/${1}.git" ${@:2}
}

# Loads the specified Git repository as a plugin.
#
# If no matching directory exists in `cobra_cache`, the repository will be cloned first.
#
# Usage
#   cobra-git <repository> [(-l <folder>)...] [(-s <file>)...]
#
# This function always returns `0`.
#
cobra-git() {
	local target=$(-cobra-dump-path ${1})

	if [[ ! -d ${target} ]]; then
		-cobra-clone ${1}
	fi

	# Make the repository available for `cobra-update`.
	_cobra_remotes+=(${1})

	if [[ $# -le 1 ]]; then
		set -- "-l" "/"
	else
		shift
	fi

	while getopts ':l:s:w' flag; do
		case ${flag} in
		w) echo ${target} ;;
		s) cobra-source "${target}/${OPTARG}" ;;
		l) cobra-load "${target}/${OPTARG}" ;;
		?) -cobra-error "Unknown flag '${OPTARG}'" ;;
		esac
	done
}

# Concurrently updates the remote sources.
#
# Usage
#   cobra-update
#
# This function always returns `0`.
#
cobra-update() {
	setopt localoptions nomonitor

	for repository in ${_cobra_remotes[@]}; do
		-cobra-clone ${repository} &
	done

	wait && -cobra-info "Done"
}

# Sources a single file.
#
# Usage
#   cobra-source <file>
#
# This function always succeeds.
#
cobra-source() {
	-cobra-debug "Found file: ${1}"
	_cobra_sources+=(${1})
}

# Sources many files.
#
# Usage
#   cobra-source-many [<file>...]
#
# This function always succeeds.
#
cobra-source-many() {
	for file; do
		cobra-source ${file}
	done
}

# Loads the specified directory as a plugin.
#
# Each pattern in `_cobra_glob_patterns` will be tested in order until any of them
# succeeds; for that pattern, the files that match it will be sourced.
#
# The function also modifies fpath to add the bundle path.
#
# Usage
#   cobra-load <directory>
#
# Returns `2` if `directory` does not exist, or `1` if some other unrecoverable error
# occurred.
#
cobra-load() {
	local -Ua files

	if [[ ! -d ${1} ]]; then
		-cobra-error "Not found: ${1}"
		return 2
	fi

	-cobra-debug "Found directory: ${1}"

	fpath+=(${1})

	for pattern in ${_cobra_glob_patterns[@]}; do
		files=(${1}/${~pattern}(N))

		if [[ $#files == 0 ]]; then
			-cobra-debug "No matches: ${pattern}"
			continue
		fi

		cobra-source-many ${files[@]}
		return $?
	done
}

# Sources pending files and finishes the loading process.
#
# This function will halt midway if any of the sources fail.
#
# Usage
#   cobra-bite
#
# Returns `1` on any error.
#
cobra-bite() {
	for file in ${_cobra_sources[@]}; do
		if ! source ${file}; then
			-cobra-error "Failed to source: ${file}"
			return 1
		fi

		-cobra-debug "Sourced: ${file}"
	done
}

# Prints the help page for Cobra.
#
# Usage
#   cobra-help
#
cobra-help() {
	echo "Usage: cobra (git <repository> | github <repository> | help | load <directory> | update | version)"
	echo
	echo "Commands:"
	echo "    bite     Sources pending files and finishes the loading process"
	echo "    git      Loads a Git repository as a plugin; clones the repository on the first run"
	echo "    github   Loads a GitHub repository as a plugin; clones the repository on the first run"
	echo "    help     Prints this help message"
	echo "    load     Loads a directory as a plugin"
	echo "    update   Updates all installed plugins"
	echo "    version  Prints the current version of this script"
}

# Program entry point and menu.
#
# Usage
#   See cobra --help
#
cobra() {
	case $1 in
	help | -h | --help | '')
		cobra-help
		;;

	version | -v | --version)
		echo 'cobra 2.3.0'
		;;

	*)
		cobra-${1} ${@:2}
		;;
	esac
}

# vim: set tw=88 ts=2 sw=2 et:
