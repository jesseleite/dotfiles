--------------------------------------------------------------------------------
-- Remember Last Cursor Position
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_cursor_position', { clear = true }),
  callback = function ()
    if vim.fn.line("'\"") >= 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd.normal('g`"')
    end
  end
})
