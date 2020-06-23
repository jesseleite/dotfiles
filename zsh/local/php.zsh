# ------------------------------------------------------------------------------
# Aliases and functions for PHP
# ------------------------------------------------------------------------------

alias psr1="php-cs-fixer fix --level=psr1"
alias psr2="php-cs-fixer fix --level=psr2"


# ------------------------------------------------------------------------------
# Switch PHP versions with less migraine?
# ------------------------------------------------------------------------------

INSTALLED_PHP_VERSIONS=('php@7.2' 'php@7.3' 'php')

phpv() {
  if [ -z "$1" ]; then
    echo 'Please specify desired PHP version!'
    return
  fi
  sudo --validate
  echo "Stopping all php services..."
  for version in $INSTALLED_PHP_VERSIONS; do
    sudo brew services stop $version
  done
  version="php@$(sed "s/php@//" <<< "$1")"
  version=$(sed "s/php@7.4/php/" <<< "$version")
  valet use $version
  echo "Updating memory_limit to 2G..."
  sed -i "" "s/memory_limit.*=.*M/memory_limit\ =\ 2G/" $(php --ini | ag "/.*/php-memory-limits.ini")
  valet restart
}
