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
    keymaps = {
      ['<Leader>E'] = require('jl.tree.helpers').open_nvim_tree_from_oil,
      --   local dir = require('oil').get_current_dir()
      --   local entry = require('oil').get_cursor_entry().name
      --   local path = dir..entry
      --   require('nvim-tree.api').tree.find_file({
      --     open = true,
      --     current_window = true,
      --     buf = path,
      --   })
      -- end,
    },
  },
}
