--------------------------------------------------------------------------------
-- Wiring Up LuaSnip
--------------------------------------------------------------------------------

-- TODO: Integrate with vim.snippet sometime like Teej?
-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/snippets.lua

local ls = require('luasnip')

local M = {}

M.expand_jump_or_tab = function ()
  if ls.expand_or_jumpable() then
    return '<Cmd>lua require("luasnip").expand_or_jump()<CR>'
  else
    return '<Tab>'
  end
end

M.jump_back = function ()
  ls.jump(-1)
end

M.change_choice = function ()
  if ls.choice_active() then
    ls.change_choice()
  end
end

return M
