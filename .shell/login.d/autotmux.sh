# On SSH connection attach to a new tmux session or previously existing one
# https://ryanmo.co/2015/05/09/automatically-attach-tmux-in-ssh-session/

# Check if tmux is installed and in a SSH seesion
if [[ "$TMUX" == "" ]] && [[ "$SSH_CONNECTION" != "" ]]; then
    # Attempt to discover a detached session and attach
    # it, else create a new session
    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null; then
		tmux -2 attach-session -t $WHOAMI
    else
        tmux -2 new-session -s $WHOAMI
    fi
fi