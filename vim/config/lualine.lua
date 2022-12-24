local noirbuddy = require('noirbuddy.plugins.lualine')

require('lualine').setup {
  options = {
    theme = noirbuddy.theme,
    icons_enabled = false,
    filetype = { colored = false },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = noirbuddy.sections,
  inactive_sections = noirbuddy.inactive_sections,
}
