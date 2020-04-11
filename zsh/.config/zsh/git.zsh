# Git-specific preferences.

# Add `bin` to path in trusted git repositories.
# See <https://twitter.com/tpope/status/165631968996900865>.
export PATH=".git/safe/../../bin${PATH:+:${PATH}}"
