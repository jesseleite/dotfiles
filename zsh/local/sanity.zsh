# ------------------------------------------------------------------------------
# Sane defaults
# ------------------------------------------------------------------------------

# Directory traversal stuff
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CHASE_LINKS
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd - > /dev/null 2>&1'

# Tweak `ls` colors
# See: https://geoff.greer.fm/lscolors/
# TODO: Not sure how to color read/write/executable permissions string like Omarchy/Linux does
# Differences between BSD and GNU ls?
export CLICOLOR=1
export LSCOLORS=exfxcxdxcxegedabagacad
# Is this needed for linux?
# export LS_COLORS=di=34:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43

# Initialize zsh completion system
autoload -Uz compinit && compinit -C

# Set terminal title to current directory, or the command name while running
case "$TERM" in
  xterm*|rxvt*)
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

# Helper to set terminal title
set_terminal_title() {
  print -Pn "\e]0;$1 (${PWD##*/})\a"
}

# Ensure xterm-256color when ssh'ing, for terminal environments like `xterm-ghostty`
# Backspace doesn't work properly without this
alias ssh='env TERM=xterm-256color ssh'
