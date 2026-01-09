--------------------------------------------------------------------------------
-- My Custom Telescope Layouts
--------------------------------------------------------------------------------

local M = {}

M.get_status_text = function (picker)
  local count = (picker.stats.processed or 0) - (picker.stats.filtered or 0)
  local total = picker.stats.processed or 0

  return string.format("%s / %s ", count, total)
end

M.helix = function (picker, max_columns, max_lines, layout_config)
  local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines, layout_config)

  -- layout.prompt.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
  layout.prompt.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

  layout.results.line = layout.results.line - 1
  layout.results.height = layout.results.height + 1
  -- layout.results.borderchars = { '─', '│  ', '─', '│', '│', '│', '┘', '└' }
  layout.results.borderchars = { '─', '│', '─', '│', '│', '│', '╯', '╰' }
  layout.results.title = ''

  if layout.preview then
    -- layout.preview.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
    layout.preview.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    layout.preview.title = 'Preview'
  end

  return layout
end

return M
