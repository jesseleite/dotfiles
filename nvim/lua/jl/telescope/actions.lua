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

-- TODO: PR 'prefix' opt to their `quote_promp()` action opts,
-- so that we don't have to maintain this whole custom func just for `prefix` opt
-- Also PR `-F -- ` into shortcut funcs
M.quote_prompt = function(opts)
  local default_opts = {
    quote_char = '"',
    prefix = "-F -- ",
    postfix = " ",
    trim = true,
  }

  opts = opts or {}
  opts = vim.tbl_extend("force", default_opts, opts)

  return function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local prompt = picker:_get_prompt()
    if opts.trim then
      prompt = vim.trim(prompt)
    end
    prompt = opts.prefix .. require("telescope-live-grep-args.helpers").quote(prompt, { quote_char = opts.quote_char }) .. opts.postfix
    picker:set_prompt(prompt)
  end
end

return M
