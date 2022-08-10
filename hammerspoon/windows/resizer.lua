local currentWindowRects
local mouseRecentlyUsed = false
local locked = true
local xMargin = 40 -- TODO: get this from grid config in below functions somehow?
local yMargin = 40 -- TODO: get this from grid config in below functions somehow?

function resetResizer()
  if locked then
    return
  end
  currentWindowRects = tableMapWithKeys(hs.window.visibleWindows(), function (win)
    return { win:id(), win:frame() }
  end)
end

function resizeAdjacentWindows(win)
  if locked then
    return
  end
  locked = true
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
  elseif y and not (w or x) then
    resizeWindowsBelow(win)
  end
  locked = false
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
    end
  end
end

-- Setup watcher to determine if mouse is being used
-- Note: For some reason, this doesn't work unless setting to `mouseWatcher` variable 🤷
mouseWatcher = hs.eventtap.new({hs.eventtap.event.types.leftMouseDown}, function(e)
  mouseRecentlyUsed = true
  hs.timer.doAfter(1, function()
    mouseRecentlyUsed = false
  end)
end):start()

-- Setup watcher for when switching spaces
hs.spaces.watcher.new(function ()
  resetResizer()
end):start()

-- Setup watcher for resizing of windows
hs.window.filter.new():subscribe(hs.window.filter.windowMoved, function(win)

  -- Do not resize adjacent windows if user doesn't explicitly hold cmd and use mouse
  if not mouseRecentlyUsed or not hs.eventtap.checkKeyboardModifiers().cmd then
    locked = false
    resetResizer()
    return
  end

  -- If user is still dragging mouse, wait for final `windowMoved` event after they let go of mouse button
  if hs.mouse.getButtons().left then
    return
  end

  locked = false
  resizeAdjacentWindows(win)
  resetResizer()
end)

-- Reset on load
resetResizer()
