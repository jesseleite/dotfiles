local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.add_commas } },
  join  = { hooks_post = { hooks.del_commas, hooks.pad_curly } },
}
