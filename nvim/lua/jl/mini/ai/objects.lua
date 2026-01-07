--------------------------------------------------------------------------------
-- My Custom Text Objects
--------------------------------------------------------------------------------

local M = {}

M.individual_html_class = function (type)
  local col = vim.fn.col('.') - 1
  local line = vim.api.nvim_get_current_line()
  local lnum = vim.fn.line('.')
  local start_col = line:sub(1, col + 1):find('[^%s"\']+$') or col + 1
  local end_col = (line:find('[%s"\']', col + 1) or #line + 1) - 1

  if type == 'a' and line:sub(end_col, end_col) == ' ' then
    end_col = end_col + 1
  end

  if type == 'a' and line:sub(start_col - 1, start_col - 1) == ' ' then
    start_col = start_col - 1
  elseif type == 'a' then
    end_col = end_col + 1
  end

  return {
    from = { line = lnum, col = start_col },
    to = { line = lnum, col = end_col },
  }
end

return M
