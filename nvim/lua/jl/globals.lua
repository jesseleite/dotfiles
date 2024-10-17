--------------------------------------------------------------------------------
-- Global Helper Functions
--------------------------------------------------------------------------------

-- Print tables and objects
P = function (v)
  print(vim.inspect(v))

  return v
end

-- Clear module cache using plenary (aka pleniarie to @theprimeagen) and re-require
R = function (module)
  require('plenary.reload').reload_module(module)

  return require(module)
end
