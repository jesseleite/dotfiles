# ------------------------------------------------------------------------------
# Aliases and functions for Laravel
# ------------------------------------------------------------------------------

# TODO: Fix herd
# This temporarily suppresses herd error for now...
function nvm_find_nvmrc() {
  #
}

alias b="herd open"
alias art="php artisan"
alias arte="[ -f .env ] || cp .env.example .env"
alias arti="comp install && arte && art key:generate"
alias artc="art clear-compiled && art cache:clear && art route:clear && art config:clear && art view:clear && comp du"
alias artm="art migrate"
alias artv="art --version"
alias artr="art route:list"
alias navi="art queue:listen --tries=2"
alias dusk="art dusk"
alias lager="less +F storage/logs/laravel.log"
alias rayi="composer require spatie/laravel-ray --dev"
alias cppint="cp ~/.dotfiles/php/pint.json pint.json && echo 'Pint formatting rules copied.'"

function tink() {(
  if [ ! -f artisan ]; then
    cd ~/Code/Playground/archon
  fi
  if [ -z "$1" ]; then
    php artisan tinker
  else
    php artisan tinker --execute="dd($1)"
  fi
)}


# ------------------------------------------------------------------------------
# Laravel Herd injected stuff
# ------------------------------------------------------------------------------

# Herd injected PHP binary.
export PATH="/Users/jesseleite/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/jesseleite/Library/Application Support/Herd/config/php/84/"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/jesseleite/Library/Application Support/Herd/config/php/83/"

# Herd injected NVM configuration
# export NVM_DIR="/Users/jesseleite/Library/Application Support/Herd/config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
