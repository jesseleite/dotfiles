# ------------------------------------------------------------------------------
# General aliases and functions
# ------------------------------------------------------------------------------

alias l='ls -lhA'
alias c="clear"
alias o="open ."
alias rf="trash"
alias sizes='du -sh -c *'
alias cwd="pwd && pwd | pbcopy && echo 'Copied to clipboard 📁'"

# Run any command from anywhere, without leaving current working directory.
#
# Usage: `in [target] [command]`
# Target: directory (if available), else `z` argument
# Example: `in sand art make:model -a SomeModel`
function in() {(
  if [ -d "$1" ]; then
    cd $1
  else
    z $1
  fi

  eval ${@:2}
)}

# Use rlwrap to fix keyboard input in scripts/commands where it's borked
function wrap() {
  rlwrap --always-readline --no-children $1
}
