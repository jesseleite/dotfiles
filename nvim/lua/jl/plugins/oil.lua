--------------------------------------------------------------------------------
-- Oil: A file explorer that you can edit like a buffer
--------------------------------------------------------------------------------

return {
  'stevearc/oil.nvim',
  keys = {
    { '<Leader>e', vim.cmd.Oil },
    -- { '<CR>', 'o', ft = 'oil_preview', remap = true }, -- TODO: Doesn't seem to be buffer local to oil_preview filetype once oil is opened once?
  },
  opts = {
    delete_to_trash = true,
  },
}
