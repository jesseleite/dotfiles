--------------------------------------------------------------------------------
-- Gitsigns: Git gutter, hunk navigation, blaming, etc.
--------------------------------------------------------------------------------

local gitsigns = lazy_require('gitsigns')

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
    { '<PageDown>', gitsigns.next_hunk },
    { '<PageUp>', gitsigns.prev_hunk },
  },
}
