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

function start_gpg_agent()
{
    # Make sure that the gpg-agent is running since ssh-pageant does not know how to start it.
    gpgconf --launch gpg-agent
    # Start ssh-pageant, use -r to reuse the "socket" if it exists.
    eval $(ssh-pageant -r -a "/tmp/S.ssh-pageant.$USERNAME") > /dev/null
}
export PATH="/c/Users/at17/scoop/apps/gpg4win/current/GnuPG/bin":$PATH
[[ -z "$SSH_CONNECTION" ]] && start_gpg_agent
