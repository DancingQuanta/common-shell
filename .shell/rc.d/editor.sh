# set editor

if [[ $OSTYPE == "linux" ]]; then
  if which vim &> /dev/null; then
    export EDITOR="vim"
  elif which vi &> /dev/null; then
    export EDITOR="vi"
  elif which nano &> /dev/null; then
    export EDITOR="nano"
  fi
  ed() {
  $EDITOR $@
  }
elif [[ $OSTYPE == "cygwin" ]]; then
  export  EDITOR='"C:/Program Files (x86)/Notepad++/notepad++.exe" -multiInst -nosession $(cygpath -w "$@")'
  ed () {
    "C:/Program Files (x86)/Notepad++/notepad++.exe" $(cygpath -w -a $@) &
  }
fi

# ed () {
# if [[ $OSTYPE == "linux" ]]; then
  # $EDITOR $@
# elif [[ $OSTYPE == "cygwin" ]]; then
  # $EDITOR $@ &
# fi
# }