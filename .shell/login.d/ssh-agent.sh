# Start ssh-agent on login
if which ssh-agent &> /dev/null; then
  SSHAGENT=$(which ssh-agent)
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS` &> /dev/null
    trap "kill $SSH_AGENT_PID" 0
  fi
fi
