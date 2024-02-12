--------------------------------------------------------------------------------
-- Lsp Keymaps
--------------------------------------------------------------------------------

local vsplit_definition = function ()
  vim.cmd.vsplit()
  vim.lsp.buf.definition()
end

local M = {}

M.setup = function ()
  vim.keymap.set('n', '<Leader>ig', vim.lsp.buf.definition, { buffer = true })
  vim.keymap.set('n', '<Leader>iv', vsplit_definition, { buffer = true })
  vim.keymap.set('n', '<Leader>id', vim.lsp.buf.declaration, { buffer = true })
  vim.keymap.set('n', '<Leader>it', vim.lsp.buf.type_definition, { buffer = true })
  vim.keymap.set('n', '<Leader>ir', vim.lsp.buf.references, { buffer = true })
  vim.keymap.set('n', '<Leader>ii', vim.lsp.buf.implementation, { buffer = true })
  vim.keymap.set('n', '<Leader>ia', vim.lsp.buf.code_action, { buffer = true })
  vim.keymap.set('n', '<Leader>ie', vim.diagnostic.open_float, { buffer = true })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true })
  vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev { buffer = true })
  vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, { buffer = true })
end

return M
