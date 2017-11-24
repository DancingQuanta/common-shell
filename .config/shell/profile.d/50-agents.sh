## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## 50-agents.sh
## This file sets up SSH and GPG agents for the shell

if [[ -x $(command -v keychain) ]]; then
  if [[ -x $(command -v gpg2) ]]; then
    eval $(keychain --eval --agents gpg,ssh --gpg2 ~/.ssh/master/*id_rsa 1E8030A9)
  else
    eval $(keychain --eval --agents gpg,ssh ~/.ssh/master/*id_rsa 1E8030A9)
  fi
elif [[ -x $(command -v ssh-agent) ]]; then
  SSHAGENT=$(which ssh-agent)
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS` &> /dev/null
    trap "kill $SSH_AGENT_PID" 0
  fi
fi
