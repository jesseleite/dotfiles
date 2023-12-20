--------------------------------------------------------------------------------
-- Phpactor: PHP refactoring and introspection tools
--------------------------------------------------------------------------------

return {
  'phpactor/phpactor',
  ft = 'php',
  build = 'composer install',
  keys = {
    { '<Leader>p', ':call phpactor#ContextMenu()<CR>', ft = 'php' },
    { '<Leader>pi', ':call phpactor#UseAdd()<CR>', ft = 'php' },
    { '<Leader>pt', ':call phpactor#Transform()<CR>', ft = 'php' },
  },
}
