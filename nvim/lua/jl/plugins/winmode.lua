return {
  'hsanson/vim-winmode',
  keys = {
    { '<Leader><Leader>w', '<Plug>WinModeResizeStart' },
  },
  init = function ()
    vim.g.win_mode_horizontal_resize_step = 6
    vim.g.win_mode_vertical_resize_step = 2
  end,
}
