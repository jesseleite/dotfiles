--------------------------------------------------------------------------------
-- Harpoon: Get to where you want with the fewest keystrokes
--------------------------------------------------------------------------------

local harpoon

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<Leader>gh', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Harpoon Menu' },
    { '<Leader>ga', function () harpoon:list():append() end, desc = 'Harpoon Append File' },
    { '<Leader>gj', function () harpoon:list():select(1) end, desc = 'Harpoon Select File 1' },
    { '<Leader>gk', function () harpoon:list():select(2) end, desc = 'Harpoon Select File 2' },
    { '<Leader>gl', function () harpoon:list():select(3) end, desc = 'Harpoon Select File 3' },
    { '<Leader>g;', function () harpoon:list():select(4) end, desc = 'Harpoon Select File 4' },
  },
  config = function ()
    harpoon = require('harpoon'):setup()
  end,
}
