# ------------------------------------------------------------------------------
# Aliases and functions for Statamic development
# ------------------------------------------------------------------------------

# Pls
alias pls="php please"

# V3
alias cmsd="in docs npm run docs:dev"
alias cmst="in cms shtuff as test"
alias cmsw="in cms npm run watch"
alias plsuser="cp ~/.dotfiles/statamic/jesseleite@gmail.com.yaml users/jesseleite@gmail.com.yaml"

# V2
alias plsc="pls clear:cache && pls clear:stache && pls clear:static && pls clear:glide"
alias plsjlo="cp ~/.dotfiles/statamic/jlo.yaml site/users/jlo.yaml"

# Talons
plscomp() { ( cd statamic && comp $* ) }

# Symlink local statamic packages, no matter how they are composer required
plslink() {
  if [ -n "$1" ]; then
    rm -rf vendor/statamic/$1
    ln -s ~/Code/$1 vendor/statamic/$1
  fi

  la vendor/statamic
}

# Setup a fresh statamic app, clear site, and install migrator
plsmig() {
  if [ -z "$1" ]; then
    echo 'Please specify repo name to create for your migration!'
    return
  fi

  cd ~/Code
  composer create-project statamic/statamic $1 --prefer-dist --stability=dev
  cd $1
  gin
  composer require statamic/migrator
  gcam 'Require migrator.'
  plslink cms
  plslink migrator
  php please site:clear -n
  gcam 'Clear site.'
  open .
  echo "\nGo forth and migrate!"
}
