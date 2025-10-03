--------------------------------------------------------------------------------
-- My Custom Telescope Pickers
--------------------------------------------------------------------------------

local builtin = require('telescope.builtin')

local M = {}

M.project_history = function ()
  builtin.oldfiles({
    prompt_title = 'Project History',
    cwd_only = true,
  })
end

M.lsp_document_methods = function ()
  builtin.lsp_document_symbols({
    prompt_title = 'LSP Document Methods',
    symbols = { 'method' },
    symbol_width = 80,
  })
end

-- M.lazy_vendor_files = function ()
--   builtin.find_files({
--     prompt_title = 'Lazy Vendor Files',
--     cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') ,
--   })
-- end

M.laravel_vendor_files = function ()
  builtin.find_files({
    prompt_title = 'Laravel Vendor Files',
    no_ignore = true,
    hidden = true,
    search_dirs = { 'vendor/laravel', 'vendor/spatie' },
  })
end

return M
