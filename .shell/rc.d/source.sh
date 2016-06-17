# Source files depending on systems

if [[ $OSTYPE == "linux" ]]; then
  echo "Nothing to declare"
elif [[ $OSTYPE == "cygwin" ]]; then
  if [[ -f "$HOME/.cygwin" ]]; then
  source "$HOME/.cygwin"
  fi
fi
