vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.del_comma_curly } },
  join  = { hooks_post = { hooks.del_comma_curly } },
}

vim.b.current_buffer_blocks_query = "^def\\  | ^defp\\  "

if vim.fn.expand('%:t'):match('_test%.exs$') then
  vim.b.current_buffer_blocks_title = 'Test Blocks'
  vim.b.current_buffer_blocks_query = "^describe\\  | ^setup\\  | ^test\\  "
end
