# ------------------------------------------------------------------------------
# Config for rex
# ------------------------------------------------------------------------------

# Report the cwd to rex (via OSC 7), so that it knows where each terminal is
# Note: Written straight to the tty, so it still gets through when the `cd`
# that triggered it has its output redirected (ie. our `-` alias)
rex_report_pwd() {
  printf '\e]7;file://%s%s\a' "$HOST" "$PWD" > "$TTY"
}

# Start the watcher that names each session after the repo (or worktree, or dir)
# of its first tab's first pane, unless it's already running
# See: rex/auto-name.lua
rex_ensure_auto_name() {
  pgrep -f 'do --all .*rex/auto-name\.lua' >/dev/null && return 0
  nohup rex do --all "$DOTFILES/rex/auto-name.lua" &>/dev/null &!
}

# Reset the session's name back to auto-naming, after renaming it manually
# Note: The watcher treats this label as its cue to take the session back over
rexs() {
  rex session rename "$REX_SESSION" '↻'
}

# Report on every directory change, and once when the shell starts
if [[ -n "$REX_SESSION" ]] && command -v rex >/dev/null 2>&1; then
  chpwd_functions+=(rex_report_pwd)
  rex_report_pwd
  rex_ensure_auto_name
fi
