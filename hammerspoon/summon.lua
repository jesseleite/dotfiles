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

  local appIsFocused = hs.application.frontmostApplication():bundleID() == id
  local appStillHasWindows = next(hs.application.find(id):allWindows())

  if appIsFocused and appStillHasWindows and lastFocusedApp and lastFocusedWindowsByApp[lastFocusedApp] then
    lastFocusedWindowsByApp[lastFocusedApp]:focus()
  else
    hs.application.open(id)
  end
end
