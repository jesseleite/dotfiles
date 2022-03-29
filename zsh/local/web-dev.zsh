# ------------------------------------------------------------------------------
# Aliases and functions for web development
# ------------------------------------------------------------------------------

# Zsh-valet settings
export VALETPHPRC_DEFAULT_PHP=php@8.1
export VALETPHPRC_DO_NOT_SHOW_PHP_VERSION=1

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
alias pegs="phpunit --exclude-group slow"

# Open shtuff receiving shell for tests with z argument
st() {
  if [ -n "$1" ]; then
    z $1
  fi

  shtuff as test
}

# Browse valet site
alias b="valet open"

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
