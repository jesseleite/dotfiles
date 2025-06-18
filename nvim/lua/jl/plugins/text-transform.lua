--------------------------------------------------------------------------------
-- Text Transform: Text transformers for switching between camelCase, etc.
--------------------------------------------------------------------------------

return {
  'chenasraf/text-transform.nvim',
  tag = 'stable',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  opts = {
    keymap = {
      telescope_popup = {
        ['n'] = '<Leader>~',
        ['v'] = '<Leader>~',
      },
    },
  },
}
