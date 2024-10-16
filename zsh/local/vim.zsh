# ------------------------------------------------------------------------------
# Aliases and functions for Vim
# ------------------------------------------------------------------------------

# Set default editor
export EDITOR='nvim'

alias vim='nvim'
alias bramvim='/opt/homebrew/bin/vim'

# Open vim with z argument
v() {
  if [ -n "$1" ]; then
    z $@
  fi

  $EDITOR
}
