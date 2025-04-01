# ------------------------------------------------------------------------------
# Aliases and functions for tmux
# ------------------------------------------------------------------------------

# Aliases
alias tl="tmux list-sessions"
alias ts="tmux new-session -s"
alias ta="tmux attach -t"
alias tksv="tmux kill-server"
alias tc="sesh connect"

# Open or create new session via fuzzy finder, or pass z style arg
t() {
  if [ -n "$1" ]; then
    sesh connect $(sesh list -c | rg $1 || echo $1)
    return
  fi

  sesh connect $(sesh list -i | gum filter --no-sort --no-strip-ansi --no-show-help --limit 1 --placeholder 'Pick a sesh!' --height 50 --prompt='  ')
}

# Ensure attached to session when opening new terminal windows
# Note: This function should be run at the end of our zshrc script to ensure
# the rest of our config is loaded if we ctrl-c out of the session picker
tmux_ensure_session() {
  if [ -z "$TMUX" ]; then
    t
  fi
}

# Kill session with z style argument, or kill current session if no argument
tks() {
  if [ -n "$1" ]; then
    tmux kill-session -t $(sesh list -c | rg $1 || echo $1)
    return
  fi

  tmux kill-session -t .
}
