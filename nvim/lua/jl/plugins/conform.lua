--------------------------------------------------------------------------------
-- Conform: A code formatter plugin
--------------------------------------------------------------------------------

local conform = require('jl.conform')

return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    formatters_by_ft = conform.formatters_by_ft,
    formatters = conform.custom_formatters,
    format_on_save = function ()
      if conform.is_enabled() then
        return {
          lsp_fallback = false,
          timeout_ms = 3000,
        }
      end
    end,
  },
  keys = {
    { '<Leader><Leader>F', conform.toggle },
  },
}
