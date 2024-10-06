--------------------------------------------------------------------------------
-- Mini.pairs: Auto-pair braces and quotes, etc.
--------------------------------------------------------------------------------

return {
  'echasnovski/mini.pairs',
  opts = {
    mappings = {
      ['`'] = { neigh_pattern = '[^\\`].' }, -- Prevent 4th backtick (https://github.com/echasnovski/mini.nvim/issues/31#issuecomment-2151599842)
    }
  },
}
