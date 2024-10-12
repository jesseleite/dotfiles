--------------------------------------------------------------------------------
-- LuaSnip: A snippet engine plugin
--------------------------------------------------------------------------------

local snippet = lazy_require('jl.luasnip')

return {
  'L3MON4D3/LuaSnip',
  build = "make install_jsregexp",
  keys = {
    { '<Tab>', snippet.expand_jump_or_tab, mode = { 'i', 's' }, expr = true },
    { '<S-Tab>', snippet.jump_back, mode = 'i' },
    { '<C-;>', snippet.change_choice, mode = 'i' },
  },
  config = function ()
    require('luasnip.loaders.from_lua').load {
      paths = vim.fn.stdpath('config') .. '/lua/jl/luasnip/snippets'
    }
  end,
}
