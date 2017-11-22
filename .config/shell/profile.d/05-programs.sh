## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## From https://github.com/ek9/shell-config
## 05-programs.sh
## This file sets up custom shell programs

# setup editors
if [[ -x $(command -v vim) ]]; then
  export EDITOR=vim
  export VISUAL=vim
  export FCEDIT=vim
elif [[ -x $(command -v vi) ]]; then
  export EDITOR=vi
  export VISUAL=vi
  export FCEDIT=vi
elif [[ -x $(command -v nano) ]]; then
  export EDITOR=vi
  export VISUAL=vi
  export FCEDIT=vi
fi

export PAGER=less
export VIEWER=$PAGER
export SYSTEMD_PAGER=$PAGER
export LESSHISTFILE=-
export LESS='-R'
export TIME_STYLE="long-iso"

# Conda
CONDA_HOME="$HOME/miniconda3"
CONDA_BIN="$CONDA_HOME/bin"
CONDA_SCRIPTS="$CONDA_HOME/Scripts"
CONDA_LIBRARY="$CONDA_HOME/Library/bin"
CONDA_PACKAGES="$CONDA_HOME/Lib/site-packages"
prepend_path $CONDA_BIN
prepend_path $CONDA_SCRIPTS
prepend_path $CONDA_LIBRARY
prepend_path $CONDA_PACKAGES

# Hook direnv on shells
[[ -x $(command -v direnv) ]] && export eval "$(direnv hook $SHELL)"

# Go environment
  
export GOPATH=$HOME/go
[[ $OSTYPE == "cygwin" ]] && export GOPATH=$(cygpath -aw $GOPATH)

# append above paths to PATH if directory exists and it is not yet in PATH
prepend_path "$GOROOT/bin"
prepend_path "$GOPATH/bin"
