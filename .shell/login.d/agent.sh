# Start agent on login
if which keychain &> /dev/null; then
  eval $(keychain --eval ~/.ssh/master/*_rsa)
elif which ssh-agent &> /dev/null; then
  SSHAGENT=$(which ssh-agent)
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS` &> /dev/null
    trap "kill $SSH_AGENT_PID" 0
  fi
fi