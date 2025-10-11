--------------------------------------------------------------------------------
-- Nvim Tree: A tree-based file explorer
--------------------------------------------------------------------------------

return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<Leader>E', function() require('nvim-tree.api').tree.open({
      current_window = true,
      find_file = true,
    }) end },
  },
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      vim.keymap.set('n', '<CR>', api.node.open.replace_tree_buffer, { buffer = bufnr })
      vim.keymap.set('n', '_', api.tree.collapse_all, { buffer = bufnr })
      vim.keymap.set('n', '-', api.node.navigate.parent_close, { buffer = bufnr })
      vim.keymap.set('n', 'g.', api.tree.toggle_hidden_filter, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>c', api.tree.close, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>e', function()
        local node = api.tree.get_node_under_cursor()
        local dir = node.type == 'directory' and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ':h')
        api.tree.close()
        require('oil').open(dir)
      end, { buffer = bufnr })
    end,
    hijack_cursor = true,
    view = {
      cursorline = false,
    },
    filters = {
      dotfiles = true,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    git = {
      enable = false,
    },
    renderer = {
      root_folder_label = false,
      add_trailing = true,
      icons = {
        padding = {
          icon = '  ',
          folder_arrow = ' ',
        },
      },
    },
  },
}
