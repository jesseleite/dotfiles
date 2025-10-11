--------------------------------------------------------------------------------
-- LuaSnip: A snippet engine plugin
--------------------------------------------------------------------------------

local s

return {
  'L3MON4D3/LuaSnip',
  build = "make install_jsregexp",
  keys = {
    { '<C-a>', function () s.change_choice() end, mode = 'i' },
  },
  config = function ()
    s = require('jl.snippets').setup()

    require('luasnip').setup {
      ft_func = require('luasnip.extras.filetype_functions').from_cursor_pos,
      update_events = { 'TextChanged', 'TextChangedI' },
      enable_autosnippets = true,
    }

    require('luasnip.loaders.from_lua').load {
      paths = {
        vim.fn.stdpath('config') .. '/lua/jl/snippets/luasnip',
      },
    }

    require('luasnip').filetype_extend("tsx", {"javascript"})
    require('luasnip').filetype_extend("javascript", {"vue"})
  end,
}
