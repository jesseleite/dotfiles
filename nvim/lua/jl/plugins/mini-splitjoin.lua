--------------------------------------------------------------------------------
-- Mini.splitjoin: Split and join arguments, array elements, etc.
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.splitjoin',
  config = function ()
    local splitjoin = require('mini.splitjoin')
    local hooks = require('jl.mini.splitjoin.hooks')

    splitjoin.setup {
      join = { hooks_post = { hooks.pad_curly } },
    }
  end,
}
