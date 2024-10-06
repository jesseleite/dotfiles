vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.add_comma_curly } },
  join  = { hooks_post = { hooks.del_comma_curly, hooks.pad_curly } },
}
