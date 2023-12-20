--------------------------------------------------------------------------------
-- Vim Help Window Tweaks
--------------------------------------------------------------------------------
-- Can probably use `after/ftplugin/help.lua` for this?
-- But `wincmd('o')` still requires a `BufWinEnter` event, so maybe it's better off here.

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help_local', { clear = true }),
  callback = function ()
    if vim.bo.buftype == 'help' then
      vim.cmd.wincmd('o') -- Fullscreen the help window
      vim.keymap.set('n', '<CR>', '<C-]>', { buffer = true })  -- Enter to go into help doc link
      vim.keymap.set('n', '<Esc>', '<C-t>', { buffer = true }) -- Esc to jump back to last help doc
    end
  end
})
