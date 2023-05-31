require'nvim-treesitter.configs'.setup {
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
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      selection_modes = {
        ['@function.outer'] = 'V',
        ['@function.inner'] = 'V',
      },
    }
  }
}
