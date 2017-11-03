## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## 50-agents.sh
## This file sets up SSH and GPG agentsfor the shell

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

