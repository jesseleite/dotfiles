--------------------------------------------------------------------------------
-- Wiring Up Snippets
--------------------------------------------------------------------------------

local ls = require('luasnip')

local M = {}

-- Curious on benefits to wiring up to the vim.snippet API like this?
-- We'll just follow Teej off the `vim.snippet` cliff blindly...
-- See: https://github.com/tjdevries/config.nvim/blob/master/lua/custom/snippets.lua
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

M.jump_forward = function ()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  end
end

M.jump_back = function ()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end

M.change_choice = function ()
  if ls.choice_active() then
    ls.change_choice()
  end
end

return M
