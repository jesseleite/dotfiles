--------------------------------------------------------------------------------
-- LuaSnip: A snippet engine plugin
--------------------------------------------------------------------------------

local s = require('jl.luasnip')

return {
  'L3MON4D3/LuaSnip',
  build = "make install_jsregexp",
  keys = {
    { '<Tab>', s.expand_jump_or_tab, expr = true, mode = { 'i', 's' } },
    { '<S-Tab>', s.jump_back, mode = 'i' },
    { '<C-a>', s.change_choice, mode = 'i' },
  },
  config = function ()
    require('luasnip.loaders.from_lua').load {
      paths = vim.fn.stdpath('config') .. '/lua/jl/luasnip/snippets'
    }
  end,
}
