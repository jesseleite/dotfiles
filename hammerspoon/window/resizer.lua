local currentWindowRects
local resetLocked = false
local lockedWinIds = {}
local wasManuallyResizing = false
local xMargin = 30 -- TODO: get this from grid config in below functions somehow?
local yMargin = 30 -- TODO: get this from grid config in below functions somehow?
local acceptableResizeRange = 2 -- account for rounding of grid cells after rect conversion

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
    resizeWindowsInSameColumn(win)
  elseif w and not (h or y) then
    resizeWindowsToRight(win)
    resizeWindowsInSameColumn(win)
  elseif h and y and not (w or x) then
    resizeWindowsAbove(win)
    resizeWindowsInSameRow(win)
  elseif h and not (w or x) then
    resizeWindowsBelow(win)
    resizeWindowsInSameRow(win)
  end
  resetLocked = false
end

function operateOnWindows(win, callback)
  local id = win:id()
  local oldRect = currentWindowRects[id]
  local newRect = win:frame()
  for specificId,specificRect in pairs(currentWindowRects) do
    callback(specificId, specificRect, oldRect, newRect)
    if specificId ~= win:id() then
      lockedWinIdsTimer:stop()
      lockedWinIdsTimer:start()
      table.insert(lockedWinIds, specificId)
    end
  end
end

function resizeWindowsToLeft(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    local adjacentEdge = adjacentRect._x + adjacentRect._w
    local oldRectEdge = oldRect._x - xMargin
    if isWithinResizeRange(adjacentEdge, oldRectEdge) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = adjacentRect._x,
        y = adjacentRect._y,
        w = adjacentRect._w - (oldRect._x - newRect._x),
        h = adjacentRect._h,
      }))
    end
  end)
end

function resizeWindowsToRight(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    local adjacentEdge = adjacentRect._x - xMargin
    local oldRectEdge = oldRect._x + oldRect._w
    if isWithinResizeRange(adjacentEdge, oldRectEdge) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = adjacentRect._x - (oldRect._w - newRect._w),
        y = adjacentRect._y,
        w = adjacentRect._w + (oldRect._w - newRect._w),
        h = adjacentRect._h,
      }))
    end
  end)
end

function resizeWindowsAbove(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    local adjacentEdge = adjacentRect._y + adjacentRect._h
    local oldRectEdge = oldRect._y - yMargin
    if isWithinResizeRange(adjacentEdge, oldRectEdge) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = adjacentRect._x,
        y = adjacentRect._y,
        w = adjacentRect._w,
        h = adjacentRect._h - (oldRect._y - newRect._y),
      }))
    end
  end)
end

function resizeWindowsBelow(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    local adjacentEdge = adjacentRect._y - yMargin
    local oldRectEdge = oldRect._y + oldRect._h
    if isWithinResizeRange(adjacentEdge, oldRectEdge) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = adjacentRect._x,
        y = adjacentRect._y - (oldRect._h - newRect._h),
        w = adjacentRect._w,
        h = adjacentRect._h + (oldRect._h - newRect._h),
      }))
    end
  end)
end

function resizeWindowsInSameColumn(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    if isWithinResizeRange(adjacentRect._x, oldRect._x) and isWithinResizeRange(adjacentRect._w, oldRect._w) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = newRect._x,
        y = adjacentRect._y,
        w = newRect._w,
        h = adjacentRect._h,
      }))
    end
  end)
end

function resizeWindowsInSameRow(win)
  operateOnWindows(win, function(adjacentId, adjacentRect, oldRect, newRect)
    if isWithinResizeRange(adjacentRect._y, oldRect._y) and isWithinResizeRange(adjacentRect._h, oldRect._h) then
      hs.window.get(adjacentId):setFrame(hs.geometry.new({
        x = adjacentRect._x,
        y = newRect._y,
        w = adjacentRect._w,
        h = newRect._h,
      }))
    end
  end)
end

function isWithinResizeRange(compareOne, compareTwo)
  local difference = math.abs(compareOne - compareTwo)
  return difference >= 0 and difference < acceptableResizeRange
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
