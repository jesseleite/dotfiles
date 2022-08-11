local currentWindowRects
local resetLocked = false
local lockedWinIds = {}
local wasManuallyResizing = false
local xMargin = 40 -- TODO: get this from grid config in below functions somehow?
local yMargin = 40 -- TODO: get this from grid config in below functions somehow?

function resetResizer()
  if resetLocked then
    return
  end
  currentWindowRects = tableMapWithKeys(hs.window.visibleWindows(), function (win)
    return { win:id(), win:frame() }
  end)
end

function resizeAdjacentWindows(win)
  if hs.fnutils.contains(lockedWinIds, win:id()) then
    return
  end
  resetLocked = true
  local id = win:id()
  local currentRect = win:frame()
  local w = false
  local x = false
  local h = false
  local y = false
  if currentWindowRects[id]._w ~= currentRect._w then
    w = true
    if currentWindowRects[id]._x ~= currentRect._x then
      x = true
    end
  end
  if currentWindowRects[id]._h ~= currentRect._h then
    h = true
    if currentWindowRects[id]._y ~= currentRect._y then
      y = true
    end
  end
  if w and x and not (h or y) then
    resizeWindowsToLeft(win)
  elseif w and not (h or y) then
    resizeWindowsToRight(win)
  elseif h and y and not (w or x) then
    resizeWindowsAbove(win)
  elseif h and not (w or x) then
    resizeWindowsBelow(win)
  end
  resetLocked = false
end

function resizeWindowsToLeft(win)
  local id = win:id()
  local oldRect = currentWindowRects[id]
  local newRect = win:frame()
  for adjacentId,rect in pairs(currentWindowRects) do
    if (rect._x + rect._w) == (oldRect._x - xMargin) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = rect._x,
        y = rect._y,
        w = newRect._x - (xMargin * 2),
        h = rect._h,
      }))
      lockedWinIdsTimer:stop()
      lockedWinIdsTimer:start()
      table.insert(lockedWinIds, adjacentId)
    end
  end
end

function resizeWindowsToRight(win)
  local id = win:id()
  local oldRect = currentWindowRects[id]
  local newRect = win:frame()
  for adjacentId,rect in pairs(currentWindowRects) do
    if (oldRect._x + oldRect._w) == (rect._x - xMargin) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = rect._x - (oldRect._w - newRect._w),
        y = rect._y,
        w = rect._w + (oldRect._w - newRect._w),
        h = rect._h,
      }))
      lockedWinIdsTimer:stop()
      lockedWinIdsTimer:start()
      table.insert(lockedWinIds, adjacentId)
    end
  end
end

function resizeWindowsAbove(win)
  local id = win:id()
  local oldRect = currentWindowRects[id]
  local newRect = win:frame()
  for adjacentId,rect in pairs(currentWindowRects) do
    if (rect._y + rect._h) == (oldRect._y - yMargin) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = rect._x,
        y = rect._y,
        w = rect._w,
        h = newRect._y - (yMargin * 2),
      }))
      lockedWinIdsTimer:stop()
      lockedWinIdsTimer:start()
      table.insert(lockedWinIds, adjacentId)
    end
  end
end

function resizeWindowsBelow(win)
  local id = win:id()
  local oldRect = currentWindowRects[id]
  local newRect = win:frame()
  for adjacentId,rect in pairs(currentWindowRects) do
    if (oldRect._y + oldRect._h) == (rect._y - yMargin) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = rect._x,
        y = rect._y - (oldRect._h - newRect._h),
        w = rect._w,
        h = rect._h + (oldRect._h - newRect._h),
      }))
      lockedWinIdsTimer:stop()
      lockedWinIdsTimer:start()
      table.insert(lockedWinIds, adjacentId)
    end
  end
end

-- Reset resizer when switching spaces
hs.spaces.watcher.new(function ()
  resetResizer()
end):start()

-- Reset resizer when removing a window
hs.window.filter.new():subscribe({
  hs.window.filter.windowDestroyed,
  hs.window.filter.windowNotVisible,
  hs.window.filter.windowHidden,
  hs.window.filter.windowMinimized,
  hs.window.filter.windowNotInCurrentSpace,
  hs.window.filter.windowNotOnScreen,
}, function()
  resetResizer()
end)

-- Ensure new windows are tracked
hs.window.filter.new():subscribe(hs.window.filter.windowCreated, function(win)
  hs.timer.doAfter(1, function()
    currentWindowRects[win:id()] = win:frame()
  end)
end)

-- Setup timer to reset `wasManuallyResizing` state, that can be cancelled as needed
wasManuallyResizingTimer = hs.timer.doAfter(2, function()
  wasManuallyResizing = false
end)

-- Setup timer to reset `lockedWinIds` state, that can be cancelled as needed
lockedWinIdsTimer = hs.timer.doAfter(1, function ()
  lockedWinIds = {}
end)

-- Setup watcher to determine if user was potentially manually resizing a window with `cmd` mod + mouse
-- Note: For some reason, this doesn't work unless setting to `wasManuallyResizingWatcher` variable 🤷
wasManuallyResizingWatcher = hs.eventtap.new({
  hs.eventtap.event.types.leftMouseDown,
  hs.eventtap.event.types.leftMouseUp,
}, function(e)
  if e:getType() == 1 and hs.eventtap.checkKeyboardModifiers().cmd == true then
    wasManuallyResizingTimer:stop()
    wasManuallyResizing = true
    wasManuallyResizingTimer:start()
  end
end):start()

-- Setup watcher for resizing of adjacent windows
hs.window.filter.new():subscribe(hs.window.filter.windowMoved, function(win)

  -- Do not resize adjacent windows if user was not manually resizing
  if not wasManuallyResizing then
    return resetResizer()
  end

  -- Do not resize adjacent windows if this window is locked
  if hs.fnutils.contains(lockedWinIds, win:id()) then
    return
  end

  -- Reset the timer in case user wants to resize twice quickly in a row
  wasManuallyResizingTimer:stop()
  wasManuallyResizingTimer:start()

  -- Okay, resize 'em!
  resizeAdjacentWindows(win)
  resetResizer()
end)

-- Reset on load
resetResizer()
