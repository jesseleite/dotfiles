# ------------------------------------------------------------------------------
# Aliases and functions for web development
# ------------------------------------------------------------------------------

# Package managers
alias comp="composer"
alias ci="composer install"
alias n="npm run"
alias ni="npm install"

# Switch composer versions
alias comp1="composer self-update --1 && composer --version"
alias comp2="composer self-update --2 && composer --version"

# Reinstall dependencies
alias deps="comp install && npm ci && npm run dev"

# Run tests
alias tp="phpunit"
alias tps="phpunit --exclude-group slow"
alias tpf="phpunit --stop-on-failure"

# Edit global composer config.
alias compc="nvim ~/.composer/config.json"

# Get installed version of a specific composer package
compv() {
  if [[ $1 == *"/"* ]]; then
    composer show $1 | grep 'versions' | grep -o -E '\*\ .+' | cut -d' ' -f2 | cut -d',' -f1;
  else
    composer info | grep $1
  fi
}
