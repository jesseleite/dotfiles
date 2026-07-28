# ------------------------------------------------------------------------------
# Aliases and functions for the robots
# ------------------------------------------------------------------------------

export OPENCODE_DISABLE_TERMINAL_TITLE=1
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1

oc() {
  set_terminal_title "opencode"
  opencode
}

cc() {
  set_terminal_title "claude"
  claude
}

gr() {
  set_terminal_title "grok"
  # Hack because grok stomps my custom title on boot...
  ( sleep 1; set_terminal_title "grok" ) &!
  command grok "$@"
}

# Ensure I always use this func to set terminal title
alias grok="gr"

# Claude code uses this
export PATH="$PATH:$HOME/.local/bin"

# Grok binary (node-independent fallback when mise project node lacks npm -g)
export PATH="$PATH:$HOME/.grok/bin"
