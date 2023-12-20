--------------------------------------------------------------------------------
-- Cellular Automaton: Give up? Run this and go for a walk!
--------------------------------------------------------------------------------

return {
  'Eandrju/cellular-automaton.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<Leader><Leader>m', ':CellularAutomaton make_it_rain<CR>' },
  },
}
