--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

local lastFocusedApp
local lastFocusedWindowsByApp = {}

hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window)
  lastFocusedApp = window:application():bundleID()
  lastFocusedWindowsByApp[lastFocusedApp] = window
end)

return function (appName)
  local id
  if apps and apps[appName] then
    id = apps[appName].id
  elseif hs.application.find(appName) then
    id = hs.application.find(appName):bundleID()
  else
    id = appName
  end
  local app = hs.application.find(id)
  local currentId = hs.application.frontmostApplication():bundleID()
  if currentId == id and not next(app:allWindows()) then
    hs.application.open(id)
  elseif currentId ~= id then
    hs.application.open(id)
  elseif lastFocusedApp and lastFocusedWindowsByApp[lastFocusedApp] then
    lastFocusedWindowsByApp[lastFocusedApp]:focus()
  end
end
