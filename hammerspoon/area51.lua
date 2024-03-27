--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------

-- Sometimes 1password lock screen opens behind other windows
hs.window.filter.new():subscribe(hs.window.filter.windowCreated, function(window)
  if window:title() == 'Lock Screen — 1Password' then
    window:focus()
  end
end)

-- -- This needs to be assigned to global var to work!?
-- play_key_watcher = hs.eventtap.new({hs.eventtap.event.types.systemDefined}, function(e)
--   if e:systemKey().key == 'PLAY' and e:systemKey().down then
--     print('playing')
--     -- Not sure we can disable the default behaviour here though,
--     -- But if we could, we can use either one of these to control itunes directly...
--     hs.itunes.playpause()
--     -- osascript -e "tell app \"Music\" to playpause"
--   end
-- end):start()

-- hs.screen.watcher.new(function ()
--   hs.reload()
-- end):start()

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

--------------------------------------------------------------------------------
-- Cal Newport Mode
--------------------------------------------------------------------------------

hs.hotkey.bind(bigHyper, '\\', function()
  print('hoteked')
  local nop = 'F24'
  apps.Telegram.summon = nop
  apps.Discord.summon = nop
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


--------------------------------------------------------------------------------
-- Grid Layout Ideas
--------------------------------------------------------------------------------

-- Two column...
-- |                       |       |
-- |          1(M)         |  2(S) |
-- |                       |       |

-- Three column...
-- |   |                   |       |
-- | 1 |        2(M)       |  3(S) |
-- |   |                   |       |

-- Four column...
-- |   |         |         |       |
-- | 1 |   2(M)  |    3    |  4(S) |
-- |   |         |         |       |

-- Streaming setup, with absolutely positioned 1920x1080 friendly cell...
-- |                               |
-- |  |  1(M)  |                   |
-- |                               |

-- Layout rules:
--     Assign layout to specific mac space only
--     Set custom grid cell sizes and margins for each layout
--     Allow for absolutely sized/positioned cells that aren't part of grid
--     Set `M` main cell alias
--     Set `S` secondary cell alias
-- App rules:
--     Global app rules
--     Per-layout app rules
--     Set default space
--     Set default cell number or alias
-- Cell snapping:
--     If app is in layout space, check app rules for cell snapping, otherwise float by default
--     Automatically snap to cell on window resize/move
--     Allow dynamic resizing of cells
-- Functions that can be configured via hotkey/modal:
--     Select layout (will reset moved apps and cell resizing to default rules)
--     Disable layout
--     Float window (detach from cell layout)
--     Focus north/east/south/west (topmost window if windows are stacked)
--     Focus next/prev windows in stack (within cell)
--     Zoom window (toggle between current cell and fullscreen cell)
--     Attach window to another cell in layout (to cell number or alias)
--     Move window to another space (to space number)
--     Show/hide all floated windows
-- Maybe someday:


--------------------------------------------------------------------------------
-- Normalize Hotkey Bindings
--------------------------------------------------------------------------------

-- hs.timer.doAfter(0.5, function()
--   hs.eventtap.keyStroke({'ctrl', 'shift'}, 'left')
--   print('wat')
-- end)

-- hs.hotkey.bind({'cmd'}, 'k', function()
--   if appIs('Brave Browser') then
--     print('Yep, it is Brave')
--   elseif appIs('Discord') then
--     print('Yep, it is Discord')
--   end
-- end)
