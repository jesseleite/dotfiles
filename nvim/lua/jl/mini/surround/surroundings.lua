--------------------------------------------------------------------------------
-- My Custom Surroundings
--------------------------------------------------------------------------------

local M = {}

-- Custom `T` surrounding so that we can `srTT` and preserve html attributes like tpope did!
-- Avoid replacing default `t` though, as we don't want this behaviour with `sa` or `sd`.
-- See: https://github.com/echasnovski/mini.nvim/issues/1293#issuecomment-2423827325
M.tag_name_only = {
  input = { '<(%w-)%f[^<%w][^<>]->.-</%1>', '^<()%w+().*</()%w+()>$' },
  output = function()
    local tag_name = require('mini.surround').user_input('Tag name (excluding attributes)')
    if tag_name == nil then return nil end
    return { left = tag_name, right = tag_name }
  end,
}

return M
