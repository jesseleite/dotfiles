--------------------------------------------------------------------------------
-- Treesitter: Syntax parsing, syntax highlighting, custom text objects, etc.
--------------------------------------------------------------------------------

local t

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    { 'nvim-treesitter/playground', cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } },
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  lazy = false,
  keys = {
    { '<A-p>', function () t.goto_node(t.get_previous_node(t.get_node_at_cursor(), true, true) ) end },
    { '<A-n>', function () t.goto_node(t.get_next_node(t.get_node_at_cursor(), true, true) ) end },
  },
  opts = {
    ensure_installed = 'all',
    ignore_install = {'phpdoc', 'ipkg'},
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<A-o>",
        scope_incremental = "<A-O>",
        node_incremental = "<A-o>",
        node_decremental = "<A-i>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['iC'] = '@class.inner',
          ['aC'] = '@class.outer',
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ic'] = '@conditional.inner',
          ['ac'] = '@conditional.outer',
          ['il'] = '@loop.inner',
          ['al'] = '@loop.outer',
          ['is'] = '@statement.outer', -- inner statement doesn't exist
          ['as'] = '@statement.outer',
          ['ia'] = '@parameter.inner', -- `a` for arg, because `p` is paragraph object
          ['aa'] = '@parameter.outer',
          ['ih'] = '@attribute.inner', -- `h` for html, because `a` is attribute above
          ['ah'] = '@attribute.outer',
        },
        selection_modes = {
          ['@class.inner'] = 'V',
          ['@class.outer'] = 'V',
          ['@function.inner'] = 'V',
          ['@function.outer'] = 'V',
          ['@conditional.inner'] = 'V',
          ['@conditional.outer'] = 'V',
          ['@loop.inner'] = 'V',
          ['@loop.outer'] = 'V',
          ['@statement.outer'] = 'V',
        },
      }
    },
    context = {
      mode = 'topline',
      multiwindow = true,
      multiline_threshold = 1,
    },
  },
  config = function (_, opts)
    require('nvim-treesitter.configs').setup(opts)
    require('treesitter-context').setup(opts.context)

    t = require('nvim-treesitter.ts_utils')
  end
}
