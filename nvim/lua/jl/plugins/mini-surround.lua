--------------------------------------------------------------------------------
-- Mini.surround: Act on surrounding parentheses, quotes, tags, etc.
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.surround',
  opts = {
    custom_surroundings = {
      T = require('jl.mini.surround.surroundings').tag_name_only,
    },
  },
}
