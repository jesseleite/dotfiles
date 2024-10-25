# ------------------------------------------------------------------------------
# Find better places for this stuff...
# ------------------------------------------------------------------------------

# Stuff from oh-my-zsh
# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
alias l='ls -lah'
# ???
# function d () {
#   if [[ -n $1 ]]; then
#     dirs "$@"
#   else
#     dirs -v | head -n 10
#   fi
# }
# compdef _dirs d

# Extra tab-completions goodness
autoload -Uz compinit && compinit -C

# Window title stuff
# TODO: why the flicker? is there a better way?
case "$TERM" in
    xterm*|rxvt*|wezterm)
        function xtitle () {
            builtin print -n -- "\e]0;$@\a"
        }
        ;;
    screen)
        function xtitle () {
            builtin print -n -- "\ek$@\e\\"
        }
        ;;
    *)
        function xtitle () {
        }
esac
function precmd () {
    xtitle "$(print -P '%~')"
}
function preexec () {
    xtitle "$1"
}


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

alias selfcontrol="/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli"

function selfcontrolblock() {
  if [ -z "$1" ]; then
    echo 'Please specify how many minutes you would like to block!'
    return
  fi

  selfcontrol start --blocklist ~/.dotfiles/bin/blocklist.selfcontrol --enddate $(date -v+${1}M -u +"%Y-%m-%dT%H:%M:%SZ")
}
