--------------------------------------------------------------------------------
-- Harpoon: Get to where you want with the fewest keystrokes
--------------------------------------------------------------------------------

local h

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<Leader>gh', function () h.ui:toggle_quick_menu(h:list()) end, desc = 'Harpoon Menu' },
    { '<Leader>ga', function () h:list():add() end, desc = 'Harpoon Add File' },
    { '<Leader>gj', function () h:list():select(1) end, desc = 'Harpoon Select File 1' },
    { '<Leader>gk', function () h:list():select(2) end, desc = 'Harpoon Select File 2' },
    { '<Leader>gl', function () h:list():select(3) end, desc = 'Harpoon Select File 3' },
    { '<Leader>g;', function () h:list():select(4) end, desc = 'Harpoon Select File 4' },
  },
  config = function ()
    h = require('harpoon'):setup()
  end,
}
