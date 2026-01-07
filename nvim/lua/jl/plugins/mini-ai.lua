--------------------------------------------------------------------------------
-- Mini.ai: Extend and create around/inside text objects
--------------------------------------------------------------------------------

-- TODO: I've been using `nvim-treesitter/nvim-treesitter-textobjects` for,
-- custom text objects, but with the refactor they are doing around the
-- treesitter ecosystem, I should look into all of this again later.

return {
  'nvim-mini/mini.ai',
  opts = {
    n_lines = 500,
    custom_textobjects = {
      c = require('jl.mini.ai.objects').individual_html_class,
    },
  },
}
