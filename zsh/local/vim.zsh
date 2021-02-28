# ------------------------------------------------------------------------------
# Aliases and functions for Vim
# ------------------------------------------------------------------------------

# Set default editor
EDITOR='vim'

# Open vim with z argument
v() {
  if [ -n "$1" ]; then
    z $1
  fi

  nvim
}
