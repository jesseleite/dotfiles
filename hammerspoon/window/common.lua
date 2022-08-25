maximizedWindows = {}

function positionAppUsingGrid(application, cell, shouldOpen)
    local app
    if shouldOpen then
        app = getOrOpenApp(application)
    else
        app = getApp(application)
    end
    if app == nil then return end
    app:unhide()
    for _, window in pairs(app:allWindows()) do
        positionWindowUsingGrid(window, cell)
    end
end

function getOrOpenApp(application)
    return hs.application.open(apps[application].id, 10)
end

function hideWindowsExcept(allowed)
  local allowedIds = hs.fnutils.map(allowed, function(appName)
    return apps[appName].id
  end)
  for _,window in pairs(hs.window.visibleWindows()) do
    local app = window:application()
    local found = hs.fnutils.find(allowedIds, function(allowedId)
      return allowedId == app:bundleID()
    end)
    if not found then
      app:hide()
    end
  end
end

function positionWindowUsingRect(window, rect)
    window.setFrame(window, rect)
end

function positionWindowUsingGrid(window, cell)
    hs.grid.set(window, cell)
end

function saveWindowToLayout(window)
    if (currentMode == "regular") then
        currentLayout.windows[window:id()] = window:frame()
    end
end

function focusNextCellWindow()
  local windows = getWindowsInFocusedCell()
  if #windows == 0 then return end
  local focusedIndex = hs.fnutils.indexOf(windows, hs.window.focusedWindow())
  local nextWindow = windows[focusedIndex+1]
  if nextWindow then
    nextWindow:focus()
  else
    local prevWindow = windows[1]
    prevWindow:focus()
  end
end

function focusPreviousCellWindow()
    local windows = getWindowsInFocusedCell()
    if #windows == 0 then return end
    local focusedIndex = hs.fnutils.indexOf(windows, hs.window.focusedWindow())
    local nextWindow = windows[focusedIndex-1]
    if nextWindow then
        nextWindow:focus()
    else
        local prevWindow = windows[#windows]
        prevWindow:focus()
    end
end

function getWindowsInFocusedCell()
    local window = hs.window.focusedWindow()
    local windows = hs.window.visibleWindows()
    windows = hs.fnutils.filter(windows, function(w) return w:frame() == window:frame() end)
    table.sort(windows, function(a, b) return a:id() < b:id() end)
    return windows
end

-- Maximizes a window, remembering the previous size.
-- When run a second time, it will restore the window to its previous size.
--
-- Stores window sizes in a table keyed by window ID.
-- { ["123"] = "10,20 3x3", ["456"] = "10,20 3x3" }
function toggleMaximized()
    local win = hs.window.focusedWindow()
    local id = win:id()

    if maximizedWindows[id] then
        positionWindowUsingRect(win, maximizedWindows[id])
        maximizedWindows[id] = nil
    else
        maximizedWindows[id] = win:frame()
        hs.grid.maximizeWindow(win)
    end
end

-- Moves a window to its default position as defined in apps.lua
function warpToDefaultPosition()
    local win = hs.window.focusedWindow()
    local app = win:application()
    local config = hs.fnutils.find(apps, function(config) return config.id == app:bundleID() end)
    if config.position then
        positionWindowUsingGrid(win, config.position)
    else
        openPositionSelector()
    end
end

function warpToExistingCellPosition()
  local chooser = hs.chooser.new(function(choice)
    if not choice then return end
    positionWindowUsingRect(hs.window.focusedWindow(), choice.window:frame())
  end)

  local windows = hs.fnutils.filter(hs.window.visibleWindows(), function(win)
    local focusedWin = hs.window.focusedWindow()
    return win:id() ~= focusedWin:id() and win:frame() ~= focusedWin:frame()
  end)
  local choices = hs.fnutils.map(windows, function(window)
    local app = window:application()
    return {
      text = app:name(),
      subText = window:title() or '--',
      window = window,
      image = hs.image.imageFromAppBundle(window:application():bundleID()),
    }
  end)
  chooser:searchSubText(true):choices(choices):query(''):show()
end

-- Puts a window on top of the last window of the same app and
-- adds it to the layout if that window is already in the layout.
function addWindowToLayoutCell(win)
    local app = win:application()
    local windows = app:allWindows()

    windows = hs.fnutils.filter(windows, function(w)
        return w:isStandard()
    end)

    if #windows < 2 then return end

    local prevTopWin = windows[2]

    if currentMode == 'regular' then
        -- Add it to the layout if the previous window was in the layout.
        if currentLayout.windows[prevTopWin:id()] then
            currentLayout.windows[win:id()] = prevTopWin:frame()
        end

        -- Position the window over the last window. Do this even if the window was
        -- not in the layout. Some apps (e.g. Safari) offset newly created windows.
        positionWindowUsingRect(win, prevTopWin:frame())
    end

    -- In focus mode, put the window in the previous layout.
    -- Once regular mode is entered, the newly created window will be positioned.
    if currentMode == 'focus' and previousLayout.windows[prevTopWin:id()] then
        previousLayout.windows[win:id()] = previousLayout.windows[prevTopWin:id()]
    end
end
