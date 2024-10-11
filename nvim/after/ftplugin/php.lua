vim.bo.commentstring = '// %s'

local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.add_commas } },
  join  = { hooks_post = { hooks.del_commas, hooks.pad_curly } },
}

vim.keymap.set('n', '<Leader>s', require('jl.telescope.pickers').lsp_document_methods, { buffer = true, desc = 'Telescope LSP Methods' });
vim.keymap.set('n', '<Leader>S', require('telescope.builtin').lsp_document_symbols, { buffer = true, desc = 'Telescope LSP Symbols' });
