--------------------------------------------------------------------------------
-- Treesitter: Syntax parsing, syntax highlighting, custom text objects, etc.
--------------------------------------------------------------------------------

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/playground', cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } },
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = 'all',
    ignore_install = {'phpdoc'},
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-o>",
        scope_incremental = "<M-O>",
        node_incremental = "<M-o>",
        node_decremental = "<M-i>",
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
    }
  }
}
