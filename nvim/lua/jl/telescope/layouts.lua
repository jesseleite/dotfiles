--------------------------------------------------------------------------------
-- My Custom Telescope Layouts
--------------------------------------------------------------------------------

local M = {}

M.helix = function(picker, max_columns, max_lines, layout_config)
  local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines, layout_config)

  layout.results.line = layout.results.line - 1
  layout.results.height = layout.results.height + 1
  layout.results.borderchars = { '─', '│  ', '─', '│', '│', '│', '┘', '└' }
  layout.prompt.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
  layout.preview.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
  layout.results.title = ''
  layout.preview.title = 'Preview'

  return layout
end

return M
