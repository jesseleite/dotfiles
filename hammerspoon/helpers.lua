--------------------------------------------------------------------------------
-- Language Helpers
--------------------------------------------------------------------------------

function map(f, t)
  n = {}

  for k,v in pairs(t) do
    n[k] = f(v);
  end

  return n;
end

function sleep(milliseconds)
  hs.timer.usleep(milliseconds * 1000)
end


--------------------------------------------------------------------------------
-- Grid Helpers
--------------------------------------------------------------------------------

function moveApp(application, cell)
  local app = hs.application.get(application)
  if app == nil then
    return false
  end
  local window = hs.application.mainWindow(app)
  if window then
    hs.grid.set(window, cell, hs.screen.mainScreen())
  end
end

function moveCurrentWindow(cell)
  hs.grid.set(hs.window.focusedWindow(), cell, hs.screen.mainScreen())
end

function snap()
  local window = hs.window.focusedWindow()
  hs.grid.snap(window)

  local application = hs.application.frontmostApplication():name()
  local cell = hs.grid.get(window)
  local position = string.format('%s,%s %sx%s', math.floor(cell.x), math.floor(cell.y), math.floor(cell.w), math.floor(cell.h))
  print(string.format('%s - %s', application, position))
end

function getPositions(sizes, leftOrRight, topOrBottom)
  local applyLeftOrRight = function (size)
    if type(positions[size]) == 'string' then
      return positions[size]
    end
    return positions[size][leftOrRight]
  end

  local applyTopOrBottom = function (position)
    local h = math.floor(string.match(position, 'x([0-9]+)') / 2)
    position = string.gsub(position, 'x[0-9]+', 'x'..h)
    if topOrBottom == 'bottom' then
      local y = math.floor(string.match(position, ',([0-9]+)') + h)
      position = string.gsub(position, ',[0-9]+', ','..y)
    end
    return position
  end

  if (topOrBottom) then
    return map(applyTopOrBottom, map(applyLeftOrRight, sizes))
  end

  return map(applyLeftOrRight, sizes)
end


--------------------------------------------------------------------------------
-- Screen Helpers
--------------------------------------------------------------------------------

function largeOrSmallScreen(large, small)
  if hs.screen.mainScreen():name() == 'LG HDR WQHD' then
    return large
  end

  return small
end

function resetWhenSwitchingScreen(f)
  f()

  hs.screen.watcher.newWithActiveScreen(function ()
    f()
  end):start()
end


--------------------------------------------------------------------------------
-- Layout Helpers
--------------------------------------------------------------------------------

function setLayout(layout, saveCurrentLayout)
  if layout then
    layouts[layout]()
    if saveCurrentLayout then
      currentLayout = layout
    end
  elseif currentLayout then
    layouts[currentLayout]()
  end
end

function resetLayout()
  currentLayout = nil
end
