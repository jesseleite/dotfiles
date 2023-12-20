--------------------------------------------------------------------------------
-- Noirbuddy: A highly customizable minimalist monochromatic colorscheme
--------------------------------------------------------------------------------

return {
  'jesseleite/nvim-noirbuddy',
  dependencies = {
    { 'tjdevries/colorbuddy.nvim', branch = 'dev' }
  },
  dev = true,
  opts = {
    preset = 'miami-nights',
    styles = {
      italic = true,
      undercurl = true,
    },
  }
}
