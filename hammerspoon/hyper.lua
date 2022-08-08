--- === Hyper ===
---
--- Hyper is a hyper shortcut modal
--- A modified version of https://github.com/evantravers/Hyper.spoon
--- Thank you Evan!

local m = {}

m.modal = hs.hotkey.modal.new({}, nil)

local pressed  = function() m.modal:enter() end
local released = function() m.modal:exit() end

function m:setHyperKey(key)
  hs.hotkey.bind({}, key, pressed, released)
  return self
end

function m:bind(...)
  m.modal:bind(...)
  return self
end

function bindHyper(key, fn)
  hyper:bind({}, key, fn)
end

return m
