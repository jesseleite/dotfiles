--------------------------------------------------------------------------------
-- Mini.statusline: A nice minimal and configurable statusline
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.statusline',
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    local noirbuddy_statusline = require('noirbuddy.plugins.mini-statusline')

    require('mini.statusline').setup {
      content = {
        active = noirbuddy_statusline.active,
        inactive = noirbuddy_statusline.inactive,
      },
    }
  end,
}
