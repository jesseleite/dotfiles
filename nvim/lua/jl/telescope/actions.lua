--------------------------------------------------------------------------------
-- My Custom Telescope Actions
--------------------------------------------------------------------------------

local M = {}

-- Bring back multiple file selection action, until core (re?)implements it.
-- See: https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
M.select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

-- Add `@` style file + method selection action
M.select_file_and_accept_method = function (prompt_bufnr)
  require('telescope.actions').select_default(prompt_bufnr)
  require('jl.telescope.pickers').lsp_document_methods()
end

return M
