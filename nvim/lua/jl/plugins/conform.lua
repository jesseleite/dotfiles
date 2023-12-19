local conform = require('jl.conform')

return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    format_on_save = function ()
      if conform.is_enabled() then
        return {
          lsp_fallback = false,
          timeout_ms = 500,
        }
      end
    end,
    formatters_by_ft = conform.formatters_by_ft,
    formatters = conform.custom_formatters,
  },
  keys = {
    { '<Leader><Leader>F', conform.toggle },
  },
}
