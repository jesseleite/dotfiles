--------------------------------------------------------------------------------
-- Wiring Up Snippets
--------------------------------------------------------------------------------

local ls = require('luasnip')

local M = {}

-- Wire up `vim.snippet` API to use Luasnip
M.setup = function ()
  vim.snippet = {
    active = function(filter)
      return ls.locally_jumpable(filter and filter.direction or 1)
    end,
    expand = ls.lsp_expand,
    jump = function(direction)
      return ls.locally_jumpable(direction) and ls.jump(direction)
    end,
    stop = ls.unlink_current,
  }

  return M
end

-- Change choice keymap helper
M.change_choice = function ()
  if ls.choice_active() then
    ls.change_choice()
  end
end

return M
