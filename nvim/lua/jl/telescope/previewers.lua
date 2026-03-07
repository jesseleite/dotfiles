--------------------------------------------------------------------------------
-- My Custom Telescope Previewers
--------------------------------------------------------------------------------

local previewers = require('telescope.previewers')

local M = {}

--- Buffer previewer that reads directly from an already-loaded buffer,
--- avoiding async file I/O so that selection + preview stay in sync.
M.buffer_line_previewer = function (source_bufnr, opts)
  opts = opts or {}

  local ns = vim.api.nvim_create_namespace('jl_telescope_preview')
  local scroll_cmd = 'norm! ' .. (opts.scroll or 'zz')

  return previewers.new_buffer_previewer({
    title = 'Preview',

    define_preview = function (self, entry)
      local lines = vim.api.nvim_buf_get_lines(source_bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      local filetype = vim.bo[source_bufnr].filetype
      if filetype and filetype ~= '' then
        vim.bo[self.state.bufnr].filetype = filetype
      end

      if entry.lnum and entry.lnum > 0 then
        pcall(vim.api.nvim_buf_set_extmark, self.state.bufnr, ns, entry.lnum - 1, 0, { end_row = entry.lnum, hl_group = 'TelescopePreviewLine' })
        -- Defer cursor positioning until after the preview buffer is attached to
        -- the window (new_buffer_previewer defers win_set_buf via vim.schedule).
        vim.schedule(function ()
          pcall(vim.api.nvim_win_set_cursor, self.state.winid, { entry.lnum, 0 })
          vim.api.nvim_buf_call(self.state.bufnr, function ()
            vim.cmd(scroll_cmd)
          end)
        end)
      end
    end,
  })
end

return M
