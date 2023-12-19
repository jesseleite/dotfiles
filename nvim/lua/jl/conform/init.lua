local formatters_by_ft = require('jl.conform.formatters')
local custom_formatters = require('jl.conform.custom')

local formatters_flattened = {}

for _,formatters in pairs(formatters_by_ft) do
  for _,formatter in pairs(formatters) do
    if not custom_formatters[formatter] then
      table.insert(formatters_flattened, formatter)
    end
  end
end

local installable_formatters = vim.fn.uniq(vim.fn.sort(formatters_flattened))

local enabled = true

local M = {
  formatters_by_ft = formatters_by_ft,
  custom_formatters = custom_formatters,
  installable_formatters = installable_formatters,
}

M.setup = function ()
  -- TODO: Figure out how to cache installable_formatters, and only run this whenever a change is detected in formatters.lua...
  -- for _,formatter in pairs(require('jl.conform').installable_formatters) do
  --   vim.cmd.MasonInstall(formatter)
  -- end
end

M.toggle = function ()
  enabled = not enabled
  print('Formatting on save ' .. (enabled and 'enabled' or 'disabled'))
end

M.is_enabled = function ()
  return enabled
end

return M
