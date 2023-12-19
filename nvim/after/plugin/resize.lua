--------------------------------------------------------------------------------
-- Equalize Window Widths On Resize
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('equalize_windows_on_resize', { clear = true }),
  callback = function ()
    vim.cmd.wincmd('=')
  end
})
