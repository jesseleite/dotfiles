--------------------------------------------------------------------------------
-- Lsp Keymaps
--------------------------------------------------------------------------------

local vsplit_definition = function ()
  vim.cmd.vsplit()
  vim.lsp.buf.definition()
end

local M = {}

M.setup = function ()
  vim.keymap.set('n', '<Leader>ig', vim.lsp.buf.definition, { buffer = true, desc = 'Go To Definition' })
  vim.keymap.set('n', '<Leader>iv', vsplit_definition, { buffer = true, desc = 'Split & Go To Definition' })
  vim.keymap.set('n', '<Leader>id', vim.lsp.buf.declaration, { buffer = true, desc = 'Go To Declaration' })
  vim.keymap.set('n', '<Leader>it', vim.lsp.buf.type_definition, { buffer = true, desc = 'Go To Type Definition' })
  vim.keymap.set('n', '<Leader>ir', vim.lsp.buf.references, { buffer = true, desc = 'List All References' })
  vim.keymap.set('n', '<Leader>ii', vim.lsp.buf.implementation, { buffer = true, desc = 'List All Implementations' })
  vim.keymap.set('n', '<Leader>ia', vim.lsp.buf.code_action, { buffer = true, desc = 'Select Code Action' })
  vim.keymap.set('n', '<Leader>ie', vim.diagnostic.open_float, { buffer = true, desc = 'Show Diagnostics' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = 'Hover Lookup' })
end

return M
