--------------------------------------------------------------------------------
-- Plugins (the ones which don't require any extra config)
--------------------------------------------------------------------------------

-- Short helper for plugins that require lua .setup() call 🤏
local s = function (plugin)
  return { plugin, config = true }
end

-- If not a simple one-liner, maybe extract to plugins folder; Otherwise just throw in here 💥
return {
  --
}
