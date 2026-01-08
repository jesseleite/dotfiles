--------------------------------------------------------------------------------
-- Mini.surround: Act on surrounding parentheses, quotes, tags, etc.
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.surround',
  opts = {
    custom_surroundings = {
      q = require('jl.mini.surround.surroundings').smart_quotes,
      T = require('jl.mini.surround.surroundings').tag_name_only,
    },
  },
}
