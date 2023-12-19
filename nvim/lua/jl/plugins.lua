--------------------------------------------------------------------------------
-- Plugins (which don't require config, see plugins dir for plugins with config)
--------------------------------------------------------------------------------

return {
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'jesseleite/vim-noh',
  'PeterRincker/vim-searchlight',
  'markonm/traces.vim',
  { 'windwp/nvim-autopairs', config = true },
  { 'nmac427/guess-indent.nvim', config = true },
  { 'JoosepAlviste/nvim-ts-context-commentstring', config = true },
}
