# ------------------------------------------------------------------------------
# Config for rex
# ------------------------------------------------------------------------------

# Reset the session's name back to auto-naming, after renaming it manually
# Note: The watcher treats this label as its cue to take the session back over
rexs() {
  rex session rename "$REX_SESSION" '↻'
}

# Resume the last agent session that quit in this tab
ra() {
  local resume=$(rex_last_agent_resume)
  [[ -n $resume ]] || { print -u2 "ra: no agent session to resume in this tab"; return 1 }
  print -r -- $resume
  eval $resume
}


# ------------------------------------------------------------------------------
# Helper Funcs
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

# Latest resume command an agent printed in this tab's scrollback, as it looks in
# each one's exit message (claude, pi, codex, and opencode)
# Note: Read off the screen, so it works the same for every agent
rex_last_agent_resume() {
  local pattern='(claude --resume|pi --session|codex resume) [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|opencode -s ses_[A-Za-z0-9]+'
  rex capture --unwrap 2>/dev/null | grep -oE $pattern | tail -n 1
}


# ------------------------------------------------------------------------------
# Post Boot
# ------------------------------------------------------------------------------

# Report on every directory change, and once when the shell starts
# Note: Down here since it runs straight away, so needs the helpers above
if [[ -n "$REX_SESSION" ]] && command -v rex >/dev/null 2>&1; then
  chpwd_functions+=(rex_report_pwd)
  rex_report_pwd
  rex_ensure_auto_name
fi
