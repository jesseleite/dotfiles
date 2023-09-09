require('neo-tree').setup {
  enable_diagnostics = false,
  enable_git_status = false,
  popup_border_style = 'single',
  window = {
    mappings = {
      ['h'] = 'close_all_subnodes',
      ['_'] = 'close_all_nodes',
    }
  },
}
