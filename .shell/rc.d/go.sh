#!/bin/sh

# Go environment

#export GOPATH=$HOME/go
if [[ $OSTYPE == "cygwin" ]]; then
  export GOPATH=$(cygpath -aw $HOME/go)
fi

prepend_path $GOROOT/bin
prepend_path $GOPATH/bin

