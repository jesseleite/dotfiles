--------------------------------------------------------------------------------
-- Flash: Jump mode, with `/` search integration, and enhanced f/F/t/T
--------------------------------------------------------------------------------

local flash = lazy_require('flash')

return {
  'folke/flash.nvim',
  dependencies = {
    'jesseleite/vim-noh',
  },
  event = 'VeryLazy',
  keys = {
    { '<Leader>j', mode = { 'n', 'x', 'o' }, flash.jump, desc = 'Flash Jump' },
    { '<C-j>', mode = { 'c' }, flash.toggle, desc = 'Toggle Flash Search' },
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
