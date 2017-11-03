## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## From https://github.com/ek9/shell-config
## 02-xdg-base-dirs.sh
## Makes sure XDG base dirs are set + move config dir to XDG home for some apps

# --- XDG Base dirs
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_DATA_HOME:=$HOME/.local/share}
: ${XDG_RUNTIME_DIR:=/run/user/$UID}

