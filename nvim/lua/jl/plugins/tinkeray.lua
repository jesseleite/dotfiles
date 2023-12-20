--------------------------------------------------------------------------------
-- Tinkeray: Artisan tinker from a Vim buffer and output to Spatie's Ray
--------------------------------------------------------------------------------

return {
  'jesseleite/vim-tinkeray',
  keys = {
    { '<Leader>gt', '<Plug>TinkerayOpen' },
    { '<Leader>rt', '<Plug>TinkerayRun' },
  },
}
