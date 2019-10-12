# ------------------------------------------------------------------------------
# Aliases and functions for Laravel
# ------------------------------------------------------------------------------

alias art="php artisan"
alias artc="art clear-compiled && art cache:clear && art route:clear && art config:clear && art view:clear && comp du"
alias artm="art migrate"
alias navi="art queue:listen --tries=2"
alias dusk="art dusk"
alias lager="less +F storage/logs/laravel.log"

function tink() {(
  if [ ! -f artisan ]; then
    cd ~/Code/Laravel
  fi
  php artisan tinker
)}

alias ting="art tinker ting.php"
