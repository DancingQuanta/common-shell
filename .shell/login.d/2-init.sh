
# OS variables
[ $(uname -s) = "Darwin" ] && export OSX=1 && export UNIX=1
[ $(uname -s) = "Linux" ] && export LINUX=1 && export UNIX=1
uname -s | grep -q "_NT-" && export WINDOWS=1

# Fix systems missing $USER
[ -z "$USER" ] && export USER=$(whoami)

quiet_which() {
  which $1 1>/dev/null 2>/dev/null
}

# Start agent on login
if which keychain &> /dev/null; then
  eval $(keychain --eval --agents gpg,ssh ~/.ssh/master/*_rsa 1E8030A9)
elif which ssh-agent &> /dev/null; then
  SSHAGENT=$(which ssh-agent)
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS` &> /dev/null
    trap "kill $SSH_AGENT_PID" 0
  fi
fi

# Hook direnv on shells
if which direnv &> /dev/null; then
  eval "$(direnv hook $SHELL)"
fi
