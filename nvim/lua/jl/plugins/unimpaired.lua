--------------------------------------------------------------------------------
-- Unimpaired: Pairs of handy bracket mappings
--------------------------------------------------------------------------------

return {
  'tpope/vim-unimpaired',
  init = function ()
    vim.g.nremap = {
      ['[e'] = '', -- disable `e` mappings for emmet
      [']e'] = '',
    }
  end,
}
