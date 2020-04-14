# ------------------------------------------------------------------------------
# General aliases and functions
# ------------------------------------------------------------------------------

alias c="clear"
alias o="open ."

# Ask alf to search aliases and functions
function alf() {
  local funcs aliases
  funcs=$(functions | php ~/.dotfiles/bin/cli_function_search.php "$*")
  aliases=$(alias | ag --color "$*")
  if [ -z "$funcs" ] || echo "\n\e[0;34mFunctions:\e[0m\n$funcs"
  if [ -z "$aliases" ] || echo "\n\e[0;34mAliases:\e[0m\n$aliases"
}

# Run any command from anywhere, without leaving current working directory.
#
# Usage: `in [target] [command]`
# Target: `shtuff` target (if available), else `z` argument
# Example: `in sand art make:model -a SomeModel`

function in() {(
  if [[ $(shtuff has $1 2>&1) =~ 'was found' ]]; then
    eval shtuff into $1 \"${@:2}\"
  else
    z $1
    eval ${@:2}
  fi
)}
