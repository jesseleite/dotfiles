# ------------------------------------------------------------------------------
# Aliases and functions for PHP
# ------------------------------------------------------------------------------

alias psr1="php-cs-fixer fix --level=psr1"
alias psr2="php-cs-fixer fix --level=psr2"


# ------------------------------------------------------------------------------
# Switch PHP versions with less migraine?
# ------------------------------------------------------------------------------

INSTALLED_PHP_VERSIONS=('php@7.2' 'php@7.3' 'php@7.4' 'php')

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
  composer global update
  version="php@$(sed "s/php@//" <<< "$1")"
  version=$(sed "s/php@8.0/php/" <<< "$version")
  valet use $version
  echo "Updating memory_limit to 2G..."
  sed -i "" "s/memory_limit.*=.*M/memory_limit\ =\ 2G/" $(php --ini | ag "/.*/php-memory-limits.ini")
  valet restart
}

phpc() {
  local confd
  confd=$(php --ini | ag -o "[^\s]*conf\.d[^/]")
  if [ -z "$1" ]; then
    cd $confd
    return
  fi
  if [ "$1" = 'xdebug' ] || [ "$1" = 'x' ]; then
    [ -f "$confd/ext-xdebug.ini" ] && rm "$confd/ext-xdebug.ini"
    [ -f "$confd/ext-xdebug.ini.disabled" ] && rm "$confd/ext-xdebug.ini.disabled"
    cp ~/.dotfiles/php/ext-xdebug.ini $confd
    echo "Copied ext-xdebug.ini"
  elif [ "$1" = 'memory' ] || [ "$1" = 'mem' ] || [ "$1" = 'm' ]; then
    sed -i "" "s/memory_limit.*=.*/memory_limit\ =\ 2G/" "$confd/php-memory-limits.ini"
    echo "Updated memory_limit to 2G"
  fi
}
