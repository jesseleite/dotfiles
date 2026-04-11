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
    -- This setting relies on unmerged PR: https://github.com/danielfalk/smart-open.nvim/pull/105
    -- open_buffer_indicators = { previous = '•', others = '◦' },
    open_buffer_indicators = false,
    -- This setting relies on unmerged PR: https://github.com/danielfalk/smart-open.nvim/pull/104
    get_status_text = function (self)
      local results = self.finder.results or {}
      local total = self.finder.total_indexed or 0
      return string.format("%s / %s ", #results, total)
    end,
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
  local cursor_line = vim.fn.line('.')
  local source_bufnr = vim.api.nvim_get_current_buf()

  require('jl.telescope.pickers').current_buffer_lines(vim.tbl_deep_extend('force', {
    prompt_title = vim.b.current_buffer_blocks_title or 'Function Blocks',
    default_text = vim.b.current_buffer_blocks_query or "^function\\  ",
    previewer = require('jl.telescope.previewers').buffer_line_previewer(source_bufnr, { scroll = 'zt' }),
    on_complete = {
      function (self)
        local best_index = nil
        for index = 1, self.manager:num_results() do
          local entry = self.manager:get_entry(index)
          if entry and entry.lnum and entry.lnum <= cursor_line then
            best_index = index
          end
        end
        self:clear_completion_callbacks()
        if best_index then
          self:set_selection(self:get_row(best_index))
        end
      end,
    },
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
