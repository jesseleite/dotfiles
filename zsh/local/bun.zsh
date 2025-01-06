# ------------------------------------------------------------------------------
# Bun injected stuff
# ------------------------------------------------------------------------------

# bun completions
[ -s "/Users/jesseleite/.bun/_bun" ] && source "/Users/jesseleite/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
