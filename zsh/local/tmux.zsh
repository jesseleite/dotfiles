# ------------------------------------------------------------------------------
# Aliases and functions for Tmux
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
