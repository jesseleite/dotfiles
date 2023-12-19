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
