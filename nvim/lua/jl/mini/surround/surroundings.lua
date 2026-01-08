--------------------------------------------------------------------------------
-- My Custom Surroundings
--------------------------------------------------------------------------------

local M = {}

-- Custom `q` surrounding that is a bit smarter than the defaults when dealing with quotes.
-- This detects which types of quotes are surrounding the cursor, and allows toggling
-- between single and double quote types (ie. ' and ") when replacing via `srqq`.
M.smart_quotes = {
  input = { "[\"'`].-[\"'`]", "^.().-().$" },
  output = function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local i = col
    while i > 0 do
      local char = line:sub(i, i)
      if char == '"' then
        return { left = "'", right = "'" }
      elseif char == "'" then
        return { left = '"', right = '"' }
      end
      i = i - 1
    end
    return { left = '"', right = '"' }
  end,
}

-- Custom `T` surrounding so that we can `srTT` and preserve html attributes like tpope did!
-- Avoid replacing default `t` though, as we don't want this behaviour with `sa` or `sd`.
-- See: https://github.com/nvim-mini/mini.nvim/issues/1293#issuecomment-2423827325
M.tag_name_only = {
  input = { '<([%w-.]-)%f[^<%w-.][^<>]->.-</%1>', '^<()[%w-.]+().*</()[%w-.]+()>$' },
  output = function()
    local tag_name = require('mini.surround').user_input('Tag name (excluding attributes)')
    if tag_name == nil then return nil end
    return { left = tag_name, right = tag_name }
  end,
}

return M
