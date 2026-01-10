# ------------------------------------------------------------------------------
# Aliases and functions for the robots
# ------------------------------------------------------------------------------

alias cc='claude'
export PATH=/Users/jesseleite/.opencode/bin:$PATH

export OPENCODE_DISABLE_TERMINAL_TITLE=1

oc() {
  set_terminal_title "opencode"
  opencode
}
