vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.commentstring = '<!-- %s -->' -- It seems this is necessary for use within <template> tags

local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.add_commas } },
  join  = { hooks_post = { hooks.del_commas, hooks.pad_curly } },
}
