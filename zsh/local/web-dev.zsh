# ------------------------------------------------------------------------------
# Aliases and functions for web development
# ------------------------------------------------------------------------------

# Package managers
alias comp="composer"
alias ci="composer install"
alias n="npm run"
alias ni="npm install"

# Reinstall dependencies
alias deps="comp install && rm -rf node_modules && npm install && npm run dev"

# Run tests
alias tp="phpunit"

# Open shtuff receiving shell for tests with z argument
st() {
  if [ -n "$1" ]; then
    z $1
  fi

  shtuff as test
}

# Browse valet site
alias b="valet open"
