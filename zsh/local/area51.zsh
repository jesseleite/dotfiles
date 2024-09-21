# ------------------------------------------------------------------------------
# Experimental Stuff
# ------------------------------------------------------------------------------

# Init zoxide
# eval "$(zoxide init zsh)"
export _ZO_RESOLVE_SYMLINKS=1

# Show my top 15 most used commands in my command history
alias favcmds="history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15"

# Check out my slides!
alias sl="slides slides.md"

# Spam requests
# repeat 100 curl -s GET http://wat.test > /dev/null && echo "Requested at" $(date)

# See longest files by filetype (ie. `filelengths php`)
function filelengths() {
  if [ -z "$1" ]; then
    echo 'Please specify filetype to search as first arg!'
    return
  fi

  rg -l '.*' -g '*.'$1 | xargs wc -l | sort
}

alias selfcontrol="/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli"

function selfcontrolblock() {
  if [ -z "$1" ]; then
    echo 'Please specify how many minutes you would like to block!'
    return
  fi

  selfcontrol start --blocklist ~/.dotfiles/bin/blocklist.selfcontrol --enddate $(date -v+${1}M -u +"%Y-%m-%dT%H:%M:%SZ")
}
