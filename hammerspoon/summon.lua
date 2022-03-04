--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

local currentlyFocusedAppName
local currentlyFocusedWindow
local lastFocusedWindow

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
  currentlyFocusedWindow = window
  currentlyFocusedAppName = appName
  print('-- Focused: (App: "' .. appName .. '", Window: "' .. window:title() .. '")')
end)

hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window, appName)
  lastFocusedWindow = window
  print('-- Last Focused Window: "' .. window:title() .. '"')
end)

function summon(appName, hideOnClose)
  hideOnClose = hideOnClose or false
  if currentlyFocusedAppName == appName and not next(hs.application.find(appName):allWindows()) then
    hs.application.open(appName)
  elseif currentlyFocusedAppName ~= appName then
    hs.application.open(appName)
  else
    if hideOnClose then
      currentlyFocusedWindow:application():hide()
    elseif lastFocusedWindow then
      lastFocusedWindow:focus()
    end
  end
end
