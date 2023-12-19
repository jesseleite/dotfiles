--------------------------------------------------------------------------------
-- Watch for External File Changes
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('check_for_external_changes', { clear = true }),
  callback = function ()
    if vim.fn.filereadable(vim.fn.bufname('%')) then
      vim.cmd.checktime()
    end
  end
})
