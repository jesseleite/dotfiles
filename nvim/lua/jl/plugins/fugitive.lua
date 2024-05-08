--------------------------------------------------------------------------------
-- Fugitive: A Git wrapper so awesome, it should be illegal
--------------------------------------------------------------------------------

return {
  'tpope/vim-fugitive',
  dependencies = {
    'tpope/vim-rhubarb',
  },
  lazy = false,
  keys = {
    { '<Leader>gs', ":Gedit :<CR>" },
    { '<Leader>gb', ":GBrowse<CR>" },
    { '<Leader>gb', ":'<,'>GBrowse<CR>", mode = 'v' },
  },
  config = function ()
    vim.api.nvim_create_autocmd('Filetype', {
      pattern = 'fugitive',
      group = vim.api.nvim_create_augroup('fugitive_open', { clear = true }),
      callback = function ()
        vim.cmd.normal('gg]]')
      end,
    })
  end,
}
