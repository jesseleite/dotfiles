# ------------------------------------------------------------------------------
# Aliases and functions for Elixir
# ------------------------------------------------------------------------------

alias iexs="iex -S mix"
alias iexp="iex --dbg pry -S mix"
alias mixfix="rm -rf .elixir_ls .expert _build && mix compile"

phxs() {
  set_terminal_title "phx.server"
  mix phx.server
}
