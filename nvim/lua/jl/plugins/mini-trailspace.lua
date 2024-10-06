--------------------------------------------------------------------------------
-- Mini.trailspace: Highlight and trim trailing whitespace
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.trailspace',
  config = function ()
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('trailspace', { clear = true }),
      callback = function ()
        require('mini.trailspace').trim()
        require('mini.trailspace').trim_last_lines()
      end,
    })
  end,
}
