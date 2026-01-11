# ------------------------------------------------------------------------------
# Experimental Stuff
# ------------------------------------------------------------------------------
# This is where I put stuff that I'm either testing or embarassed about.
# No shame; Just aliens, UFOs, cows, and crazy nonsense shenanigans.

# Always read man pages with gum pager
man() {
  /usr/bin/man $1 | gum pager
}

# Show my top 15 most used commands in my command history
alias favcmds="history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15"

# Check out my slides!
alias sl="slides slides.md"

# See longest files by filetype (ie. `filelengths php`)
function filelengths() {
  if [ -z "$1" ]; then
    echo 'Please specify filetype to search as first arg!'
    return
  fi

  rg -l '.*' -g '*.'$1 | xargs wc -l | sort
}

# Ping until internet is connected/re-connected
internet() {
  disconnected=false

  while ! ping 8.8.8.8 -c 1 &> /dev/null; do
    echo '❌ No internet connection.'
    disconnected=true
    sleep 1;
  done;

  # Show notification only if it was ever disconnected, so you
  # can leave the command running in the background.
  if $disconnected; then
    osascript -e 'display notification "Connection restored ✅" with title "Internet"'
  fi

  echo '✅ Connected to internet.'
}

alias selfcontrol="/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli"

function selfcontrolblock() {
  if [ -z "$1" ]; then
    echo 'Please specify how many minutes you would like to block!'
    return
  fi

  selfcontrol start --blocklist ~/.dotfiles/bin/blocklist.selfcontrol --enddate $(date -v+${1}M -u +"%Y-%m-%dT%H:%M:%SZ")
}
