--------------------------------------------------------------------------------
-- Copilot: AI Autocompletion
--------------------------------------------------------------------------------

return {
  "zbirenbaum/copilot.lua",
  build = ":Copilot auth",
  lazy = false,
  opts = {
    suggestion = {
      enabled = false, -- Using copilot-cmp instead!
    },
    panel = {
      enabled = false,
    },
  },
}
