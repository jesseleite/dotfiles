# ------------------------------------------------------------------------------
# Aliases and functions for the robots
# ------------------------------------------------------------------------------

export OPENCODE_DISABLE_TERMINAL_TITLE=1

oc() {
  set_terminal_title "oc"
  opencode
}

cc() {
  set_terminal_title "cc"
  claude
}
