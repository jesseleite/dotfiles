--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

local lastFocusedWindow

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window)
  print('-- Focused: (App: "' .. window:application():name() .. '", Bundle ID: "' .. window:application():bundleID() .. '", Window: "' .. window:title() .. '", Window ID: "' .. window:id() .. '")')
end)

hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window)
  lastFocusedWindow = window
end)

function summon(appName)
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
  elseif lastFocusedWindow then
    lastFocusedWindow:focus()
  end
end
