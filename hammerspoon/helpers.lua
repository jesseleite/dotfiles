function map(f, t)
  n = {}

  for k,v in pairs(t) do
    n[k] = f(v);
  end

  return n;
end

-- Get the number of items in a table
function size(table)
  local count = 0
  for k,v in pairs(table) do
    count = count + 1
  end
  return count
end

function printi(...)
  return print(hs.inspect(...))
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

function getApp(appName)
  return hs.application.get(apps[appName].id)
end

function isAppVisible(appName)
  local app = getApp(appName)
  return app and not app:isHidden()
end

function isAppOpen(appName)
  return getApp(appName) ~= nil
end

function isAppClosed(appName)
  return not isAppOpen(appName)
end
