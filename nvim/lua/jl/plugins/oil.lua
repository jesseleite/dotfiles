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
    keymaps = {
      ['<Leader>E'] = function()
        local dir = require('oil').get_current_dir()
        local entry = require('oil').get_cursor_entry().name
        local path = dir..entry
        require('nvim-tree.api').tree.find_file({
          open = true,
          current_window = true,
          buf = path,
        })
        if vim.fn.isdirectory(path) == 1 then
          require('nvim-tree.api').node.open.edit()
        end
      end,
    },
  },
}
