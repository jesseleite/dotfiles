--------------------------------------------------------------------------------
-- Undotree: Branching undo history visualizer
--------------------------------------------------------------------------------

return {
  'mbbill/undotree',
  keys = {
    { '<Leader><Leader>u', vim.cmd.UndotreeToggle },
  }
}
