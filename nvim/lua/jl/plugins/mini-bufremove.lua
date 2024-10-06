--------------------------------------------------------------------------------
-- Bufremove: Close buffer without closing window or split
--------------------------------------------------------------------------------

local bufremove = lazy_require('mini.bufremove')

return {
  'echasnovski/mini.bufremove',
  keys = {
    { '<Leader>c', bufremove.delete, silent = true }
  }
}
