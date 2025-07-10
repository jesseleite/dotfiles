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

  # TODO: Can I dry this up to make it reusable in my tmux.conf as well?
  # Tmux config seems to have trouble running shell interactively on custom user funcs.
  # That said, I'm passing --border and --margin differently here though.
  sesh connect $(
    sesh list -i -H | fzf --reverse --no-sort --ansi --info 'hidden' --prompt '  > ' \
      --border \
      --margin 3,15 \
      --bind 'ctrl-a:reload(sesh list -i -H)' \
      --bind 'ctrl-t:reload(sesh list -t -i -H)' \
      --bind 'ctrl-g:reload(sesh list -c -i -H)' \
      --bind 'ctrl-z:reload(sesh list -z -i -H)' \
      --bind 'ctrl-f:reload(fd -H -d 5 -t d . ~/Code)' \
      --bind 'ctrl-x:execute(tmux kill-session -t {2..})+reload(sesh list -i -H)' \
      --bind 'ctrl-r:execute(eval echo {2} | xargs zoxide remove)+reload(sesh list -i -H)' \
      --preview-window 'right:60%:border-left' \
      --preview 'sesh preview {}' \
  )
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
