--------------------------------------------------------------------------------
-- PromptYank: Copy selection with path, line numbers, etc. for LLM prompts
--------------------------------------------------------------------------------

return {
  "polacekpavel/prompt-yank.nvim",
  keys = {
    { '<Leader>y', vim.cmd.PromptYank, desc = "Yank for LLM" },
  },
}
