--------------------------------------------------------------------------------
-- Wiring Up Lsps
--------------------------------------------------------------------------------

local servers = require('jl.lspconfig.servers') -- Check this out for individual server configs
local keymaps = require('jl.lspconfig.keymaps') -- Check this out for lsp related keymaps

local M = {}

M.setup = function ()
  for server,config in pairs(servers) do
    if type(config) == 'boolean' then
      config = {}
    end

    config.on_attach = keymaps.setup

    config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig')[server].setup(config)
  end
end

return M
