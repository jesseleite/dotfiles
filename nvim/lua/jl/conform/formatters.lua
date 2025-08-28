--------------------------------------------------------------------------------
-- Configured Formatters by Filetype
--------------------------------------------------------------------------------

return {
  -- lua = { 'stylua' }, -- See project stylua.toml for rules. TODO: Seems to heavy handed?
  php = { 'pint' },
  go = { 'goimports' },
  json = { 'fixjson', 'pint' },
  html = { 'antlersformat' },
  elixir = { 'mix' },
}
