--------------------------------------------------------------------------------
-- QF Helper: Quickfix list improvements
--------------------------------------------------------------------------------

local telescope_quickfix = function ()
  vim.cmd.cclose()
  require('telescope.builtin').quickfix()
end

return {
  'stevearc/qf_helper.nvim',
  main = 'qf_helper',
  lazy = false,
  opts = {
    quickfix = {
      min_height = 5,
      track_location = false,
    },
    loclist = {
      min_height = 5,
      track_location = false,
    },
  },
  keys = {
    { '<Leader><Leader>q', vim.cmd.QFToggle },
    { '<Leader><Leader>l', vim.cmd.LLOpen },
    { 'dd', vim.cmd.Reject, ft = 'qf' },
    { 'd', ":'<,'>Reject<CR>", ft = 'qf', mode = 'v' },
    -- And these are not qf_helper, but might as well keep quickfix stuff together (I do what I want)...
    { 'p', '<CR><C-W>p', ft = 'qf' },
    { '<Leader>t', telescope_quickfix, ft = 'qf' },
  },
}
