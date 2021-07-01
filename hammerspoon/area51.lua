--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------

-- Specifically for recording vim gifs on retina
hs.hotkey.bind(hyper, 'g', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.w = 1200
  f.h = 850
  win:setFrameInScreenBounds(f)
end)

-- -- Video stuff
-- hs.hotkey.bind(hyper, 'v', chain({'1,3 14x13'}))
-- hs.hotkey.bind(hyper, 't', chain({'15,3 14x13'}))
hs.hotkey.bind(hyper, 'q', function()
  hs.window.focusedWindow():setFrame({x = 62, y = 220, w = 1920, h = 1080})
end)


----------------------------------------------------------------------------------
---- Grid Helpers
----------------------------------------------------------------------------------

---- use hs.fnutils.map() instead
--function map(f, t)
--  n = {}

--  for k,v in pairs(t) do
--    n[k] = f(v);
--  end

--  return n;
--end

--function moveApp(application, cell)
--  local app = hs.application.get(application)
--  if app == nil then
--    return false
--  end
--  local window = hs.application.mainWindow(app)
--  if window then
--    hs.grid.set(window, cell, hs.screen.mainScreen())
--  end
--end

--function moveCurrentWindow(cell)
--  hs.grid.set(hs.window.focusedWindow(), cell, hs.screen.mainScreen())
--end

--function snap()
--  local window = hs.window.focusedWindow()
--  hs.grid.snap(window)

--  local application = hs.application.frontmostApplication():name()
--  local cell = hs.grid.get(window)
--  local position = string.format('%s,%s %sx%s', math.floor(cell.x), math.floor(cell.y), math.floor(cell.w), math.floor(cell.h))
--  print(string.format('%s - %s', application, position))
--end

--function getPositions(sizes, leftOrRight, topOrBottom)
--  local applyLeftOrRight = function (size)
--    if type(positions[size]) == 'string' then
--      return positions[size]
--    end
--    return positions[size][leftOrRight]
--  end

--  local applyTopOrBottom = function (position)
--    local h = math.floor(string.match(position, 'x([0-9]+)') / 2)
--    position = string.gsub(position, 'x[0-9]+', 'x'..h)
--    if topOrBottom == 'bottom' then
--      local y = math.floor(string.match(position, ',([0-9]+)') + h)
--      position = string.gsub(position, ',[0-9]+', ','..y)
--    end
--    return position
--  end

--  if (topOrBottom) then
--    return map(applyTopOrBottom, map(applyLeftOrRight, sizes))
--  end

--  return map(applyLeftOrRight, sizes)
--end


----------------------------------------------------------------------------------
---- Layout Helpers
----------------------------------------------------------------------------------

--function setLayout(layout, saveCurrentLayout)
--  if layout then
--    layouts[layout]()
--    if saveCurrentLayout then
--      currentLayout = layout
--    end
--  elseif currentLayout then
--    layouts[currentLayout]()
--  end
--  hs.notify.show('Layout Set', '', layout)
--end

--function resetLayout()
--  currentLayout = nil
--  hs.notify.show('Layout Reset', '', '')
--end

--------------------------------------------------------------------------------
-- Grid Settings
--------------------------------------------------------------------------------

-- hs.window.animationDuration = 0
-- hs.grid.setGrid('30x20')
-- hs.grid.setMargins('36x36')

-- positions = {
--   full     = '0,0 30x20',

--   center = {
--     wide   = '2,1 26x18',
--     normal = '6,1 18x18',
--     narrow = '10,1 10x18',
--   },

--   thirds = {
--     left   = '0,0 10x20',
--     center = '10,0 10x20',
--     right  = '20,0 10x20',
--   },

--   halves = {
--     left   = '0,0 15x20',
--     right  = '15,0 15x20',
--   },

--   twoThirds = {
--     left   = '0,0 20x20',
--     right  = '10,0 20x20',
--   },

--   fourFifths = {
--     left   = '0,0 24x20',
--     center = '3,0 24x20',
--     right  = '6,0 24x20',
--   },
-- }


--------------------------------------------------------------------------------
-- Grid Movements
--------------------------------------------------------------------------------
-- f:    fullscreen
-- hjkl: edge movements
-- yu:   top corner movements
-- bn:   bottom corner movements
-- m:    middle column
-- s:    snap to nearest grid region

-- local chain = require('chain')

-- hs.hotkey.bind(hyper, 'f', chain({positions.full}))
-- hs.hotkey.bind(hyper, 'c', chain({positions.center.normal, positions.center.wide, positions.center.narrow}))

-- local chainX = { 'thirds', 'halves', 'twoThirds', }
-- local chainY = { 'thirds', 'full' }

-- hs.hotkey.bind(hyper, 'h', chain(getPositions(chainX, 'left')))
-- hs.hotkey.bind(hyper, 'j', chain(getPositions(chainY, 'center', 'bottom')))
-- hs.hotkey.bind(hyper, 'k', chain(getPositions(chainY, 'center', 'top')))
-- hs.hotkey.bind(hyper, 'l', chain(getPositions(chainX, 'right')))
-- hs.hotkey.bind(hyper, 'y', chain(getPositions(chainX, 'left', 'top')))
-- hs.hotkey.bind(hyper, 'u', chain(getPositions(chainX, 'right', 'top')))
-- hs.hotkey.bind(hyper, 'b', chain(getPositions(chainX, 'left', 'bottom')))
-- hs.hotkey.bind(hyper, 'n', chain(getPositions(chainX, 'right', 'bottom')))
-- hs.hotkey.bind(hyper, 'm', chain(getPositions(chainY, 'center')))

-- hs.hotkey.bind(hyper, 's', function ()
--   snap()
-- end)


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------
-- w: work layout
-- s: secondary space layout
-- r: reset current layout

-- currentLayout = nil

-- layouts = {

--   w = function ()
--     moveApp('kitty', positions.twoThirds.right)
--     moveApp('Google Chrome', positions.thirds.left)
--     moveApp('Ray', positions.thirds.left)
--     moveApp('Tower', positions.thirds.center)
--     moveApp('Slack', '20,0 10x10')
--     moveApp('Discord', '20,10 10x10')
--   end,

--   s = function ()
--     moveApp('Music', '1,1 12x18')
--     moveApp('Messages', '15,9 7x10')
--     moveApp('Telegram', '14,9 6x9')
--     moveApp('Discord', '21,2 8x11')
--   end,

-- }

-- layoutModal = activateModal(hyper, 'l')

-- modalBind(layoutModal, 'w', function () setLayout('w', true) end)
-- modalBind(layoutModal, 's', function () setLayout('w', true) end)
-- modalBind(layoutModal, 'r', function () resetLayout() end)
