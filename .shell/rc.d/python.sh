#!/bin/sh

# Useful python aliases and functions

# Update pip modules
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# Compile python scripts, useful for checking for any syntax issues
alias pycheck="python -m py_compile"

# Start ipython with a script
ipy() {
  if [[ $# -eq 0 ]]; then
    if [[ -f ./ipython.py ]]; then
      echo "ipython.py found!"
      echo "Launching ipython with ipython.py as startup script"
      cygstart -- ipython -i ipython.py
    else
      echo "Launching ipython without a startup script or ipython.py"
      cygstart ipython
    fi
  else
      echo "Launching ipython with $1 as startup script and ${@:2} as arguments"
      cygstart -- ipython -i $(cygpath -w -a $1) ${@:2}
  fi
}
