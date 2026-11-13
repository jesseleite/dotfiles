# ------------------------------------------------------------------------------
# Aliases and functions for Vim
# ------------------------------------------------------------------------------

# Set default editor
export EDITOR='nvim'

alias vim='v'
alias bramvim='/opt/homebrew/bin/vim'

# Open vim with z argument
# Note: The title is set here rather than by neovim itself, so that neovim leaves
# the title alone when another program opens it (ie. hunk, git, etc.)
v() {
  if [ -n "$1" ]; then
    z $@
  fi

  set_terminal_title_with_pwd "vim"
  $EDITOR
}
