--------------------------------------------------------------------------------
-- Configured Formatters by Filetype
--------------------------------------------------------------------------------

return {
  -- lua = { 'stylua' }, -- See project stylua.toml for rules. TODO: Seems to heavy handed?
  php = { 'pint' },
  json = { 'fixjson', 'pint' },
  html = { 'antlersformat' },
}
