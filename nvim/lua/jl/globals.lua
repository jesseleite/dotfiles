--------------------------------------------------------------------------------
-- Rad Global Helpers (stolen from TJ Devries)
--------------------------------------------------------------------------------
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/globals.lua
-- https://github.com/tjdevries/lazy-require.nvim

local require = require
local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require

if ok then
  reloader = plenary_reload.reload_module
end

-- Print tables and objects
P = function (v)
  print(vim.inspect(v))

  return v
end

-- Clear module cache
RELOAD = function (...)
  local ok, plenary_reload = pcall(require, "plenary.reload")

  if ok then
    reloader = plenary_reload.reload_module
  end

  return reloader(...)
end

-- Clear module cache and require
R = function (name)
  RELOAD(name)

  return require(name)
end

-- Defer require until exported function is called
lazy_require = function (require_path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(require_path)[k](...)
      end
    end,
  })
end
