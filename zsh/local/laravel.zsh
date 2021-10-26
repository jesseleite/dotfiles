# ------------------------------------------------------------------------------
# Aliases and functions for Laravel
# ------------------------------------------------------------------------------

alias art="php artisan"
alias arte="[ -f .env ] || cp .env.example .env"
alias arti="comp install && arte && art key:generate"
alias artc="art clear-compiled && art cache:clear && art route:clear && art config:clear && art view:clear && comp du"
alias artm="art migrate"
alias navi="art queue:listen --tries=2"
alias dusk="art dusk"
alias lager="less +F storage/logs/laravel.log"

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
# Install Laravel Ray and globally gitignored tinkeray.php file into project
# ------------------------------------------------------------------------------

function rayi() {
  composer require spatie/laravel-ray --dev
  if [ ! -f tinkeray.php ]; then
    echo "<?php\n\n\$test = 'tinkeray ready';\n\nray(\$test);" >> tinkeray.php
    echo "Created file [tinkeray.php]"
  else
    echo "File already exists [tinkeray.php]"
  fi
}
