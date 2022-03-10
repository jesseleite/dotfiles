# ------------------------------------------------------------------------------
# Aliases and functions for tmux
# ------------------------------------------------------------------------------

# Unalias omz's ta
unalias ta

# Attach to session
ta() {
  if [ -n "$1" ]; then
    tmux attach -t $1
    return
  fi

  tmux ls && read tmux_session && tmux attach -t ${tmux_session:-misc} || tmux new -s ${tmux_session:-misc}
}

# Ensure attached to session when opening new terminal windows
if [ -z "$TMUX" ]; then
  ta
fi

# Open or create tmux session with z argument
t() {
  if [ -z "$1" ]; then
    ta
    return
  fi

  local sesh=$(basename $(z -e $1) | tr . _)

  if [ -z $TMUX ]; then
    (z $1 && tmux new -A -s $sesh)
  elif tmux has-session -t=$sesh 2> /dev/null; then
    (tmux switch -t $sesh)
  else
    (z $1 && tmux new -A -s $sesh -d && tmux switch -t $sesh)
  fi
}


# ------------------------------------------------------------------------------
# Experimenting with tmuxinator
# ------------------------------------------------------------------------------

alias tx="tmuxinator"

# Unalias oh-my-zsh aliases, in favour of following functions
unalias txs

# Attempt to start tmuxinator on Statamic project using z argument, otherwise just just tmuxinator start
txs() {
  if [ -f "$(z -e $1)/please" ]; then
    tmuxinator start statamic $1
    return
  fi

  tmuxinator start $1
}
