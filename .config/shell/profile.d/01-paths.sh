## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## From https://github.com/ek9/shell-config
## 01-paths.sh
## Sets up PATH

## Functions to manipulate paths

# Remove a path from PATH
remove_from_path() {
  [ -d $1 ] || return
  # Doesn't work for first item in the PATH but don't care.
  export PATH=$(echo ":$PATH:" | sed "s@:$1:@:@g;s@^:\(.*\):\$@\1@") 2>/dev/null
}

# Add to beginning of path,
prepend_path() {
  [ -d $1 ] || return
  $(echo ":$PATH:" | grep -q ":$1:") && remove_from_path "$1"
  export PATH="$1:$PATH"
}

append_path() {
  [ -d "$1" ] || return
  $(echo ":$PATH:" | grep -q ":$1:") && remove_from_path "$1"
  export PATH="$PATH:$1"
}

# enable local bin dir
HOMEBIN="$HOME/.local/bin"
prepend_path $HOMEBIN

## append $HOMEBIN to PATH if directory exists and it is not yet in PATH
#if [[ $UID -ge 1000 ]] && [[ -d $HOMEBIN ]] && [[ -z $(echo $PATH | grep -o $HOMEBIN) ]]; then
    #export PATH=$PATH:$HOMEBIN
#fi
