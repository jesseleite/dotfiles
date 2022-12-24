--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------

local Color, colors, Group, groups, styles = require('colorbuddy').setup {}

require('noirbuddy').setup {
  preset = 'miami-nights',
  styles = {
    italic = true,
  },
}

Group.new('CursorLineNr', colors.noir_9, colors.noir_9)
Group.new('VertSplit', nil, nil)
Group.new('StatusLine', nil, nil)
Group.new('StatusLineNC', nil, colors.background)
Group.new('Searchlight', nil, colors.secondary)
Group.new('Sneak', nil, colors.primary)


--------------------------------------------------------------------------------
-- Everything Else Cosmetic
--------------------------------------------------------------------------------

-- Customize vertical split character
vim.opt.fillchars = { vert = ' ' }

-- Highlight 121st character on lines that exceed 120
vim.fn.matchadd('ColorColumn', '\\%121v')

local signs = {
  DiagnosticSignError = "❱❱",
  DiagnosticSignWarn = "❱❱",
  DiagnosticSignHint = "❱❱",
  DiagnosticSignInfo = "❱❱",
}

for name, sign in pairs(signs) do
  vim.fn.sign_define(name, { texthl = name, text = sign })
end
