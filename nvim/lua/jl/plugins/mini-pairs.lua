--------------------------------------------------------------------------------
-- Mini.pairs: Auto-pair braces and quotes, etc.
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.pairs',
  opts = {
    mappings = {
      ['`'] = { neigh_pattern = '[^\\`].' }, -- Prevent 4th backtick (https://github.com/nvim-mini/mini.nvim/issues/31#issuecomment-2151599842)
    }
  },
}
