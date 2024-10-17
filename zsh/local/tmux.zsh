# ------------------------------------------------------------------------------
# Aliases and functions for tmux
# ------------------------------------------------------------------------------

# Open or create new session
t() {
  if [ -n "$1" ]; then
    sesh connect $(sesh list -c | rg $1 || echo $1)
    return
  fi

  sesh connect $(sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh!' --height 50 --prompt='  ')
}

# Ensure attached to session when opening new terminal windows
# Note: This is defined as a function and should be run at the end of user's zshrc script to
# ensure the rest of the user's config is loaded if they ctrl-c out of the session picker
tmux_ensure_session() {
  if [ -z "$TMUX" ]; then
    t
  fi
}
