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
    { '<Leader>j', function () require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Jump' },
    { '<C-j>', function () require('flash').toggle() end, mode = { 'c' }, desc = 'Toggle Flash Search' },
  },
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        highlight = {
          backdrop = false,
          groups = {
            label = 'FlashCurrent',
          },
        },
      },
    },
  },
}
