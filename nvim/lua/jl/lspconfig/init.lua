--------------------------------------------------------------------------------
-- Wiring Up Lsps
--------------------------------------------------------------------------------

local servers = require('jl.lspconfig.servers') -- Check this out for individual server configs
local keymaps = require('jl.lspconfig.keymaps') -- Check this out for lsp related keymaps

local on_attach = function ()
  keymaps.setup()
end

local M = {}

M.setup = function ()
  for server,config in pairs(servers) do
    if type(config) == 'boolean' then
      config = {}
    end

    config.on_attach = on_attach

    require('lspconfig')[server].setup(config)
  end
end

return M
