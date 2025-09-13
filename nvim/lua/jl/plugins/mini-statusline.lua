--------------------------------------------------------------------------------
-- Mini.statusline: A nice minimal and configurable statusline
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.statusline',
  dependencies = {
    'nvim-mini/mini.icons',
  },
  config = function ()
    require('mini.statusline').setup {
      content = {
        active = require('noirbuddy.plugins.mini-statusline').active,
        inactive = require('noirbuddy.plugins.mini-statusline').inactive,
      },
    }
  end,
}
