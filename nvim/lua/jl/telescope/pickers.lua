--------------------------------------------------------------------------------
-- My Custom Telescope Pickers
--------------------------------------------------------------------------------

local builtin = require('telescope.builtin')

local M = {}

-- TODO: These don't all work in `telescope.extensions.smart_open`, maybe we can move this later?
M.smart_open = function ()
  require('telescope').extensions.smart_open.smart_open({
    prompt_title = 'Smart Open Files',
    cwd_only = true,
    match_algorithm = 'fzf',
    result_limit = 50,
    filename_first = false,
    -- open_buffer_indicators = false, -- Would be nice to disable these altogether. See: https://github.com/danielfalk/smart-open.nvim/issues/38
    -- get_status_text = function () return "" end, -- This always renders `0`, and override doesn't work? PR a fix?
  })
end

M.project_history = function ()
  builtin.oldfiles({
    prompt_title = 'Project History',
    cwd_only = true,
  })
end

M.current_buffer_lines = function (opts)
  builtin.current_buffer_fuzzy_find(vim.tbl_deep_extend('force', {
    prompt_title = 'Current Buffer Lines',
    sorter = require('jl.telescope.sorters').fzf_index_sorter(),
  }, opts or {}))
end

M.current_buffer_blocks = function (opts)
  require('jl.telescope.pickers').current_buffer_lines(vim.tbl_deep_extend('force', {
    prompt_title = vim.b.current_buffer_blocks_title or 'Function Blocks',
    default_text = vim.b.current_buffer_blocks_query or "^function\\  ",
  }, opts or {}))
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
