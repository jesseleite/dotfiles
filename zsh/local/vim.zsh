# ------------------------------------------------------------------------------
# Aliases and functions for Vim
# ------------------------------------------------------------------------------

# Set default editor
export EDITOR='nvim'

# Open vim with z argument
v() {
  if [ -n "$1" ]; then
    z $1
  fi

  $EDITOR
}
