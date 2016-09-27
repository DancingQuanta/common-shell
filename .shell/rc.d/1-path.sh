#
#  Path manipulation and path settings
#

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

# Set paths

if [[ -f $HOME/.path ]]; then
  source $HOME/.path
fi
