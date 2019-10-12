# ------------------------------------------------------------------------------
# Aliases and functions for PHP
# ------------------------------------------------------------------------------

alias psr1="php-cs-fixer fix --level=psr1"
alias psr2="php-cs-fixer fix --level=psr2"

# Easily switch between PHP versions with brew and valet.
#
# Slighly modified from Freek's great post: # https://murze.be/easily-switch-php-versions-in-laravel-valet
#
# Setup Instructions:
# - Brew uninstall all versions of PHP.
# - Run `brew tap exolnet/homebrew-deprecated` (for EOL PHP versions).
# - Run `brew install php@5.6 php@7.0 php@7.1 php@7.2 php@7.3`.
# - Restart and run function to install your desired version.

INSTALLED_PHP_VERSIONS=('php@5.6' 'php@7.0' 'php@7.1' 'php@7.2' 'php@7.3')

phpv() {
    valet stop
    for version in $INSTALLED_PHP_VERSIONS; do
        brew services stop $version
        brew unlink $version
    done
    brew link --force --overwrite $1
    brew services restart $1
    composer global update
    valet install
}

alias php56="phpv php@5.6"
alias php70="phpv php@7.0"
alias php71="phpv php@7.1"
alias php72="phpv php@7.2"
alias php73="phpv php@7.3"
