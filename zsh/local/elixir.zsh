# ------------------------------------------------------------------------------
# Aliases and functions for Elixir
# ------------------------------------------------------------------------------

alias iexs="iex -S mix"
alias iexp="iex --dbg pry -S mix"

phxs() {
  set_terminal_title "phx.server"
  mix phx.server
}
