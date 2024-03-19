# ------------------------------------------------------------------------------
# Experimental Stuff
# ------------------------------------------------------------------------------

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
