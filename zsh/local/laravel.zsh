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
alias rayi="comp require spatie/laravel-ray --dev"

function tink() {(
  if [ ! -f artisan ]; then
    cd ~/Code/Playground/laravel
  fi
  if [ -z "$1" ]; then
    php artisan tinker
  else
    php artisan tinker --execute="dd($1)"
  fi
)}

