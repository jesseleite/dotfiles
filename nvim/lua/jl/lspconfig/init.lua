--------------------------------------------------------------------------------
-- Wiring Up Lsps
--------------------------------------------------------------------------------

local servers = require('jl.lspconfig.servers') -- Check this out for individual server configs
local keymaps = require('jl.lspconfig.keymaps') -- Check this out for lsp related keymaps

local M = {}

M.setup = function ()
  -- Use notifications for LSP messages, so that pressing ENTER isn't required
  -- TODO: If I use a nicer notifications plugin, do I need this?
  vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
    vim.notify(result.message, result.type)
  end

  for server,config in pairs(servers) do
    if type(config) == 'boolean' then
      config = {}
    end

    config.on_attach = keymaps.setup

    config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end
end

return M
