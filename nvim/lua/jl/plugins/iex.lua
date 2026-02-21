--------------------------------------------------------------------------------
-- IEx: Run Elixir's IEx on a scratch file within Neovim
--------------------------------------------------------------------------------

return {
  'jesseleite/iex.nvim',
  lazy = false,
  keys = {
    { '<Leader>gi', vim.cmd.IEx, desc = 'IEx' },
  },
  config = true,
}
