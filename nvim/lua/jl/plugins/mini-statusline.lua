--------------------------------------------------------------------------------
-- Mini.statusline: A nice minimal and configurable statusline
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.statusline',
  dependencies = {
    'echasnovski/mini.icons',
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
