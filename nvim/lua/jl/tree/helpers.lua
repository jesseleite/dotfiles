--------------------------------------------------------------------------------
-- File Tree Helpers
--------------------------------------------------------------------------------

local M = {}

M.open_nvim_tree_from_oil = function ()
  local oil = require('oil')
  local dir = oil.get_current_dir()
  local entry = oil.get_cursor_entry().name
  local path = dir..entry
  require('nvim-tree.api').tree.find_file({
    open = true,
    current_window = true,
    buf = path,
  })
end

M.open_oil_from_nvim_tree = function ()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  local dir = vim.fn.fnamemodify(node.absolute_path, ':h')
  api.tree.close()
  require('oil').open(dir)
  vim.defer_fn(function()
    vim.fn.search(node.name)
  end, 100)
end

return M
