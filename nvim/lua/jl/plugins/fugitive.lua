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
  }
}

-- TODO: Do I still want these?
-- augroup disable_plugins_in_fugitive
--  autocmd!
--  autocmd Filetype fugitive DisableWhitespace
--  autocmd Filetype fugitive normal gg]]
-- augroup END
