--------------------------------------------------------------------------------
-- Configured Formatters by Filetype
--------------------------------------------------------------------------------

return {
  elixir = { 'mix' },
  go = { 'goimports' },
  php = { 'pint' },
  json = { 'fixjson', 'pint' },
  html = { 'antlersformat' },
  -- lua = { 'stylua' }, -- See project stylua.toml for rules. TODO: Seems to heavy handed?
  -- javascript = { 'prettier' },
  -- vue = { 'prettier' },
  -- javascriptreact = { 'prettier' },
}
