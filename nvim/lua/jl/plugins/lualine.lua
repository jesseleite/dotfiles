--------------------------------------------------------------------------------
-- Lualine: Highly configurable status line
--------------------------------------------------------------------------------

return {
  'nvim-lualine/lualine.nvim',
  config = function ()
    local noirbuddy = require('noirbuddy.plugins.lualine')
    local colors = require('noirbuddy.colors').all()

    -- Screencasting settings
    local screencasting = false
    -- vim.g.video_title = '"That One Micro Talk on Macros" by Jesse Leite 😎'
    -- vim.g.video_series = '@ NeovimConf.Live'
    vim.g.video_title = '😎'
    vim.g.video_series = 'Vim for Normal People'

    -- Customize theme for screencasting
    if screencasting then
      local custom_theme = noirbuddy.theme
      custom_theme.normal.c.bg = colors.noir_9
    end

    -- Customize sections for screencasting
    local custom_sections
    if screencasting then
      custom_sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'g:video_title' },
        lualine_z = { 'g:video_series' }
      }
    end

    require('lualine').setup {
      options = {
        theme = custom_theme or noirbuddy.theme,
        icons_enabled = false,
        filetype = { colored = false },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = custom_sections or noirbuddy.sections,
      inactive_sections = noirbuddy.inactive_sections,
    }
  end
}
