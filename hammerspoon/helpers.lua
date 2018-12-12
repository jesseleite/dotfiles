--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

function map(f, t)
  n = {}

  for k,v in pairs(t) do
    n[k] = f(v);
  end

  return n;
end

function moveApp(application, cell)
  -- hs.application.launchOrFocus(application)
  local window = hs.window.find(application)

  if (window) then
    hs.grid.set(window, cell, hs.screen.mainScreen())
  end
end

function snap()
  local window = hs.window.focusedWindow()
  hs.grid.snap(window)

  local application = hs.application.frontmostApplication():name()
  local cell = hs.grid.get(window)
  local position = string.format('%s,%s %sx%s', math.floor(cell.x), math.floor(cell.y), math.floor(cell.w), math.floor(cell.h))
  print(string.format('%s - %s', application, position))
end

function largeOrSmallScreen(large, small)
  if hs.screen.mainScreen():name() == 'LG HDR WQHD' then
    return large
  end

  return small
end

function getPositions(sizes, leftOrRight, topOrBottom)
  local applyLeftOrRight = function (size)
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
