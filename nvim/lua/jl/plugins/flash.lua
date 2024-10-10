--------------------------------------------------------------------------------
-- Flash: Jump mode, with `/` search integration, and enhanced f/F/t/T
--------------------------------------------------------------------------------

return {
  'folke/flash.nvim',
  dependencies = {
    'jesseleite/vim-noh',
  },
  event = 'VeryLazy',
  keys = {
    { '<Leader>j', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash Jump' },
    { '<C-j>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
  },
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        highlight = {
          backdrop = false,
        },
      },
    },
  },
}
