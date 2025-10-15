--------------------------------------------------------------------------------
-- Gitsigns: Git gutter, hunk navigation, blaming, etc.
--------------------------------------------------------------------------------

return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    signs = {
      add       = { text = '▎' },
      change    = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add       = { text = '▎' },
      change    = { text = '▎' },
      untracked = { text = '▎' },
    },
  },
  keys = {
    { '<PageDown>', function () require('gitsigns').nav_hunk('next') end },
    { '<PageUp>', function () require('gitsigns').nav_hunk('prev') end },
  },
}
