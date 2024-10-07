--------------------------------------------------------------------------------
-- Generic Colorscheme Tweaks
--------------------------------------------------------------------------------

local Group = require('colorbuddy').Group
local colors = require('colorbuddy').colors

Group.new('CursorLineNr', colors.noir_9, colors.noir_9)
Group.new('WinSeparator', nil, nil)
Group.new('StatusLine', nil, nil)
Group.new('StatusLineNC', nil, colors.background)


--------------------------------------------------------------------------------
-- Diagnostic Signs
--------------------------------------------------------------------------------

local signs = {
  DiagnosticSignError = "❱❱",
  DiagnosticSignWarn = "❱❱",
  DiagnosticSignHint = "❱❱",
  DiagnosticSignInfo = "❱❱",
}

for name, sign in pairs(signs) do
  vim.fn.sign_define(name, { texthl = name, text = sign })
end


--------------------------------------------------------------------------------
-- Other Cosmetic Tweaks
--------------------------------------------------------------------------------

-- Highlight 121st character on lines that exceed 120, but only after alpha start screen is closed!
vim.cmd[[
  autocmd User AlphaClosed lua vim.fn.matchadd('ColorColumn', '\\%121v')
]]

-- Highlight briefly on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
  callback = function ()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 150,
      on_macro = true
    }
  end
})
