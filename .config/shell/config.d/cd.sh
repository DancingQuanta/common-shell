#!/usr/bin/env sh
## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## cd.sh
## Aliases and functions of cd

# Aliases

alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias .....='cd ../../../.. && ls'
alias back='cd $OLDPWD && ls'

# Functions

# cdl()
#
# Usage:
#   cdl <path>
#
# Description:
#   Change to the given directory and run `ls`.
cdl() {
  cd "${1:-}" || return
  ls -lah
}

# mkd()
#
# Usage:
#   mkd <path>
#
# Description:
#   Create a new directory with `mkdir -p` and enter it.
mkd() {
  mkdir -p "$@" && cd "$_" || return
}
