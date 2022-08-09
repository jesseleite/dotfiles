--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"} -- or D+F 🤘
bigHyper = {"shift", "cmd", "alt", "ctrl"} -- or S+D+F 😅

hs.loadSpoon("ReloadConfiguration"):start()

require('helpers')
require('area51')
require('windows')

positions = require('positions')
apps = require('apps')
layouts = require('layouts')
summon = require('summon')
chain = require('chain')


--------------------------------------------------------------------------------
-- Summon Specific Apps
--------------------------------------------------------------------------------

hs.fnutils.each(apps, function(app)
  if app.summon then
    hs.hotkey.bind(app.summon[1], app.summon[2], function() summon(app.id) end)
  end
end)

local summonModalBindings = tableFlip(hs.fnutils.map(apps, function(app)
  return app.summonModal
end))

registerModalBindings(hyper, 'space', hs.fnutils.map(summonModalBindings, function(app)
  return function() summon(app) end
end), true)


--------------------------------------------------------------------------------
-- Window Management Setup
--------------------------------------------------------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid('30x20')
hs.grid.setMargins('40x40')


--------------------------------------------------------------------------------
-- Window Focus Movements
--------------------------------------------------------------------------------

local windowFocusBindings = {
  ['h'] = function() hs.window.focusedWindow():focusWindowWest(nil, true) end,
  ['j'] = function() hs.window.focusedWindow():focusWindowSouth(nil, true) end,
  ['k'] = function() hs.window.focusedWindow():focusWindowNorth(nil, true) end,
  ['l'] = function() hs.window.focusedWindow():focusWindowEast(nil, true) end,
}

registerKeyBindings(hyper, hs.fnutils.map(windowFocusBindings, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- Single Window Movements
--------------------------------------------------------------------------------
-- hl:   side column movements
-- k:    fullscreen and middle column movements
-- j:    centered window movements
-- yu:   top corner movements
-- nm:   bottom corner movements
-- i:    insert/snap to nearest grid region

local chainX = { 'thirds', 'halves', 'twoThirds', 'fiveSixths', 'sixths' }
local chainY = { 'full', 'thirds' }

local singleWindowMovements = {
  ['h'] = chain(getPositions(chainX, 'left')),
  ['k'] = chain(getPositions(chainY, 'center')),
  ['j'] = chain({ positions.center.large, positions.center.medium, positions.center.small, positions.center.tiny, positions.center.mini }),
  ['l'] = chain(getPositions(chainX, 'right')),
  ['y'] = chain(getPositions(chainX, 'left', 'top')),
  ['u'] = chain(getPositions(chainX, 'right', 'top')),
  ['n'] = chain(getPositions(chainX, 'left', 'bottom')),
  ['m'] = chain(getPositions(chainX, 'right', 'bottom')),
  -- ['m'] = snap
}

registerKeyBindings(bigHyper, hs.fnutils.map(singleWindowMovements, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------

local layoutModalBindings = {
  ['l'] = openLayoutSelector,
  ['r'] = resetLayout,
  ['k'] = hideFloatingWindows,
  ['m'] = toggleMaximized,
  ['o'] = toggleFocusMode,
  ['t'] = toggleAlternateLayout,
  ['f'] = toggleFocusMode,
  ['n'] = focusNextCellWindow,
  ['p'] = focusPreviousCellWindow,
  ['x'] = removeWindowFromLayout,
  ['d'] = warpToDefaultPosition,
  ['w'] = warpToExistingCellPosition,
  ['s'] = saveLayoutSnapshot,
}

registerModalBindings(hyper, 'l', hs.fnutils.map(layoutModalBindings, function(fn)
  return function() fn() end
end), true)


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
