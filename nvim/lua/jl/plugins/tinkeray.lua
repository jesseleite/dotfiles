--------------------------------------------------------------------------------
-- Tinkeray: Artisan tinker from a Vim buffer and output to Spatie's Ray
--------------------------------------------------------------------------------

return {
  'jesseleite/vim-tinkeray',
  branch = 'feature/multiple-scratch-files', -- Use this experimental branch
  event = 'VeryLazy', -- Set to always load for now, until we figure out :TinkerayOpen for multiple scratch files
  keys = {
    { '<Leader>gt', '<Plug>TinkerayOpen' },
    { '<Leader>rt', '<Plug>TinkerayRun' },
  },
}
