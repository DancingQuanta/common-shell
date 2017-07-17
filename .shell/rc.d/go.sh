#!/bin/sh

# Go environment

if [[ $OSTYPE == "cygwin" ]]; then
  export GOPATH=$(cygpath -aw $HOME/go)
else
  export GOPATH=$HOME/go
fi

prepend_path $GOROOT/bin
prepend_path $GOPATH/bin

