--------------------------------------------------------------------------------
-- Mini.statusline: A nice minimal and configurable statusline
--------------------------------------------------------------------------------

local noirbuddy_statusline = lazy_require('noirbuddy.plugins.mini-statusline')

return {
  'echasnovski/mini.statusline',
  dependencies = {
    'echasnovski/mini.icons',
  },
  opts = {
    content = {
      active = noirbuddy_statusline.active,
      inactive = noirbuddy_statusline.inactive,
    },
  },
}
