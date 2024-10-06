--------------------------------------------------------------------------------
-- Mini.splitjoin: Split and join arguments, array elements, etc.
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.splitjoin',
  config = function ()
    local splitjoin = require('mini.splitjoin')

    local curly = { brackets = { '%b{}' } }

    local add_comma_curly = splitjoin.gen_hook.add_trailing_separator(curly)
    local del_comma_curly = splitjoin.gen_hook.del_trailing_separator(curly)
    local pad_curly = splitjoin.gen_hook.pad_brackets(curly)

    require('mini.splitjoin').setup {
      split = { hooks_post = { add_comma_curly } },
      join  = { hooks_post = { del_comma_curly, pad_curly } },
    }
  end,
}
