local servers = require('jl.lspconfig.servers')
local keymaps = require('jl.lspconfig.keymaps')

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
