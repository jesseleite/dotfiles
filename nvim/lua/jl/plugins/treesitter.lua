--------------------------------------------------------------------------------
-- Treesitter: Syntax parsing, syntax highlighting, custom text objects, etc.
--------------------------------------------------------------------------------

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
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
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["if"] = "@function.inner",
          ["af"] = "@function.outer",
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
        selection_modes = {
          ['@function.inner'] = 'V',
          ['@function.outer'] = 'V',
        },
      }
    }
  }
}
