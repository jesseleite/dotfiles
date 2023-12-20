--------------------------------------------------------------------------------
-- Bbye: Close buffer without closing window or split
--------------------------------------------------------------------------------

return {
  'moll/vim-bbye',
  keys = {
    { '<Leader>c', vim.cmd.Bdelete, silent = true }
  }
}
