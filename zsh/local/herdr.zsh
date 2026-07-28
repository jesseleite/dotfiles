# ------------------------------------------------------------------------------
# Config for herdr
# ------------------------------------------------------------------------------

# Herdr hardcodes TERM=xterm-256color, but its emulator is actually libghostty,
# so advertise ghostty's real capabilities (truecolor, styled underlines, etc.)
# when the terminfo entry is available.
# See: https://github.com/ogulcancelik/herdr/discussions/554
if [[ -n "$HERDR_ENV" && "$TERM" == "xterm-256color" ]] && infocmp -x xterm-ghostty &>/dev/null; then
  export TERM=xterm-ghostty
fi
