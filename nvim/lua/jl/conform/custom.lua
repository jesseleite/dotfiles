--------------------------------------------------------------------------------
-- Custom Formatter Definitions (formatters not auto-handled by conform)
--------------------------------------------------------------------------------

return {
  antlersformat = {
    command = 'antlersformat',
    args = { 'format', "$FILENAME" },
    stdin = false,
  },
}
