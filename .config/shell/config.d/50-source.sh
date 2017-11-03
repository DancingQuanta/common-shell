# Source files depending on systems

if [[ $OSTYPE == "linux" ]]; then
  echo "Nothing to declare"
elif [[ $OSTYPE == "cygwin" ]]; then
  if [[ -f "$HOME/.config/cygwin" ]]; then
  source "$HOME/.config/cygwin" 
  fi
fi

# Set configuration for local shell

if [[ -f "$HOME/.config/local-shell" ]]; then
  source "$HOME/.config/local-shell"
fi

