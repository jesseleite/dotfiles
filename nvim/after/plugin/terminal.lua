--------------------------------------------------------------------------------
-- Terminal Window Tweaks
--------------------------------------------------------------------------------
-- Teej said we can just use `after/ftplugin/term.lua` for this?
-- But `set filtype?` is empty? Is this a thing? Does this require nightly?

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('terminal_local', { clear = true }),
  callback = function ()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd.startinsert()
    vim.cmd.DisableWhitespace()
    vim.keymap.set('n', '<Leader>q', ':bd!<CR>', { buffer = true, silent = true })
    vim.keymap.set('n', '<Leader>c', ':bd!<CR>', { buffer = true, silent = true })
    vim.keymap.set('n', '<C-c>', ':bd!<CR>', { buffer = true, silent = true })
  end
})
