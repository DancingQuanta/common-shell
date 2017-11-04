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

# Hook direnv on shells
[[ -x $(command -v direnv) ]] && export eval "$(direnv hook $SHELL)"

# Go environment
  
export GOPATH=$HOME/go
  
if [[ $OSTYPE == "cygwin" ]]; then
  export GOPATH=$(cygpath -aw $GOPATH)
fi

# append above paths to PATH if directory exists and it is not yet in PATH
if [[ $UID -ge 1000 ]] && [[ -d "$GOROOT/bin" ]] && [[ -z $(echo $PATH | grep -o "$GOROOT/bin") ]]; then
    export PATH=$PATH:"$GOROOT/bin"
fi
if [[ $UID -ge 1000 ]] && [[ -d "$GOPATH/bin" ]] && [[ -z $(echo $PATH | grep -o "$GOPATH/bin") ]]; then
    export PATH=$PATH:"$GOPATH/bin"
fi

# Github hub
[[ -x $(command -v hub) ]] && eval "$(hub alias -s)"
