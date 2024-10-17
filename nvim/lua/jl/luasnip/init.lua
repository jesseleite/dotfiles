--------------------------------------------------------------------------------
-- Wiring Up LuaSnip
--------------------------------------------------------------------------------

-- TODO: Integrate with vim.snippet sometime like Teej?
-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/snippets.lua

local M = {}

M.expand_jump_or_tab = function ()
  if require('luasnip').expand_or_jumpable() then
    return '<Cmd>lua require("luasnip").expand_or_jump()<CR>'
  else
    return '<Tab>'
  end
end

M.jump_back = function ()
  require('luasnip').jump(-1)
end

M.change_choice = function ()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice()
  end
end

return M
