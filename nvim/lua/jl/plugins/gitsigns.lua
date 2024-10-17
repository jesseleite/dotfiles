--------------------------------------------------------------------------------
-- Gitsigns: Git gutter, hunk navigation, blaming, etc.
--------------------------------------------------------------------------------

return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    signs = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      untracked    = { text = '▎' },
    }
  },
  keys = {
    { '<PageDown>', function () require('gitsigns').next_hunk() end },
    { '<PageUp>', function () require('gitsigns').prev_hunk() end },
  },
}
