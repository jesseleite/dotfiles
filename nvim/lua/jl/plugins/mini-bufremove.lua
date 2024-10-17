--------------------------------------------------------------------------------
-- Mini.bufremove: Close buffer without closing window or split
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.bufremove',
  keys = {
    { '<Leader>c', function () require('mini.bufremove').delete() end, silent = true },
  },
}
