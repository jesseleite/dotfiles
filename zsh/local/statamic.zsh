# ------------------------------------------------------------------------------
# Aliases and functions for Statamic development
# ------------------------------------------------------------------------------

# Pls
alias pls="php please"

# V3
alias plsi="arti && plsuser"
alias plsv="art --version && pls --version"
alias plsr="art route:list"
alias plsrf="art route:list --except-path=cp"
alias cmsw="in cms npm run watch"
alias plsuser="cp ~/.dotfiles/statamic/jesseleite@example.com.yaml users/jesseleite@example.com.yaml && echo 'User created.'"
alias plspro="pls pro:enable"
alias cpant="cp ~/.dotfiles/statamic/antlers.format.json .antlers.format.json && echo 'Antlers formatting rules copied.'"
alias lstatamic="~/Code/Wilderborn/cli/bin/statamic"

# V2
alias plsc="pls clear:cache && pls clear:stache && pls clear:static && pls clear:glide"
alias plsjlo="cp ~/.dotfiles/statamic/jlo.yaml site/users/jlo.yaml"

plsdaily() {
  open -g "bear://x-callback-url/create?title=Daily%20Todo&tags=statamic%2Fdaily&timestamp=yes&text=%0A%0A-%20%5B%20%5D%20Check%20email%0A-%20%5B%20%5D%20Help%20Scout%20support%0A-%20%5B%20%5D%20Github%20notifications%0A-%20%5B%20%5D%20Fix%20a%20bug%0A%0A%23%23%20Goals%0A%0A-%20"
}

plsweekly() {
  open -g "bear://x-callback-url/create?title=Weekly%20Todo&tags=statamic%2Fweekly&timestamp=yes&text=%0A%0A-%20%5B%20%5D%20Create%20knowledge%20base%20article%0A-%20%5B%20%5D%20Create%20short%20video%20tutorial%0A%0A%23%23%20Goals%0A%0A-%20"
}

# Symlink local statamic packages/assets, no matter how they are composer required
plslink() {
  if [ "$1" = 'cms' ]; then
    plslinkcms
  elif [ -n "$1" ]; then
    rm -rf vendor/statamic/$1
    ln -s ~/Code/Wilderborn/$1 vendor/statamic/$1
  fi

  echo "\nIn vendor/statamic:"
  l vendor/statamic
  echo "\nIn public/vendor/statamic:"
  l public/vendor/statamic
}

# Symlink local worktree from statamic/cms specifically
plslinkcms() {
  local worktree=$(cd ~/Code/Wilderborn/cms && git worktree list | rg -v 'bare' | gum filter --placeholder 'Symlink which worktree...' | awk '{ print $1 }')
  if [ -z "$worktree" ]; then
    return
  fi

  rm -rf vendor/statamic/cms
  ln -s $worktree vendor/statamic/cms
  rm -rf public/vendor/statamic/cp
  ln -s $worktree/resources/dist public/vendor/statamic/cp
  rm -rf public/vendor/statamic/frontend
  ln -s $worktree/resources/dist-frontend public/vendor/statamic/frontend
}

# Setup a fresh starter kit with user
plsnew() {
  if [ -z "$1" ]; then
    echo 'Please specify repo name to create for your starter kit site!'
    return
  fi

  cd ~/Code/Playground
  statamic new -n $1 statamic/starter-kit-cool-writings
  cd $1
  plsuser
  plspro
  cpant
  gin
  b
}

# Setup a fresh statamic app, clear site, and install migrator
plsmig() {
  if [ -z "$1" ]; then
    echo 'Please specify repo name to create for your migration!'
    return
  fi

  cd ~/Code/Playground
  comp create-project statamic/statamic $1 --prefer-dist --stability=dev
  cd $1
  gin
  comp require statamic/migrator
  echo 'DISABLE_MIGRATOR_STATS=true' >> .env
  gcam 'Require migrator.'
  plslink cms
  plslink migrator
  plslink dist
  pls site:clear -n
  gcam 'Clear site.'
  o
  plsuser
  echo "\nGo forth and migrate!"
}

plsv3() {
  statamic install $1
}
