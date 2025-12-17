--------------------------------------------------------------------------------
-- Oil: A netrw-like file explorer that you can edit like a buffer
--------------------------------------------------------------------------------

return {
  'stevearc/oil.nvim',
  keys = {
    { '<Leader>e', vim.cmd.Oil },
  },
  opts = {
    delete_to_trash = true,
    view_options = {
      case_insensitive = true,
    },
    confirmation = {
      border = 'rounded',
    },
    keymaps = {
      ['<Leader>E'] = require('jl.tree.helpers').open_nvim_tree_from_oil,
    },
  },
}
