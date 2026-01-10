--------------------------------------------------------------------------------
-- Custom Formatter Definitions (formatters not auto-handled by conform)
--------------------------------------------------------------------------------

return {
  antlersformat = {
    command = 'antlersformat',
    args = { 'format', "$FILENAME" },
    stdin = false,
  },

  -- TODO: this is slow, async this?
  -- recode = {
  --   command = 'mix',
  --   args = { 'recode', "$FILENAME" },
  --   stdin = false,
  -- },
  --
  -- TODO: Probably not here, but as lsp config...
  -- credo = {
  --   command = 'antlersformat',
  --   args = { 'format', "$FILENAME" },
  --   stdin = false,
  -- },
}
