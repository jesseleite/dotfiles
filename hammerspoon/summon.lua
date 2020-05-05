--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

-- Note: When two or more app instances of the same name are running,
-- it's not always possible to get all of those instances via hs.application.find(),
-- and such was the case with Alacritty.  I'm not sure if this is a bug with
-- Hammerspoon?  Anyway, I was able to get this working by looping over
-- all running application windows and checking their names manually.

local lastFocusedBeforeSummon = {}

function summon(appName)
  local appFound = false
  local appIsVisible = false
  local appSummoned = false
  local apps = getAllRunningAppsWithName(appName)
  for key,app in pairs(apps) do
    appFound = true
    appIsVisible = not app:isHidden()
  end
  if appFound then
    for key,app in pairs(apps) do
      if appIsVisible then
        local lastFocused = hs.window.focusedWindow()
        if (lastFocused:application():name() == appName) then
          lastFocusedBeforeSummon[appName] = lastFocused
        end
        app:hide()
      else
        app:mainWindow():focus()
        appSummoned = true
      end
    end
    if lastFocusedBeforeSummon[appName] and appSummoned then
      lastFocusedBeforeSummon[appName]:focus()
    end
  else
    hs.application.launchOrFocus(appName)
  end
end

function getAllRunningAppsWithName(appName)
  local apps = {}
  for key,window in pairs(hs.window.allWindows()) do
    if window:application():name() == appName then
      table.insert(apps, window:application())
    end
  end
  return apps
end
