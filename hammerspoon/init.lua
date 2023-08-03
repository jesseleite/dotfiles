--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"} -- or D+F 🤘
bigHyper = {"shift", "cmd", "alt", "ctrl"} -- or S+D+F 😅

hs.loadSpoon("ReloadConfiguration"):start()

require('helpers')
require('area51')

positions = require('positions')
apps = require('apps')
layouts = require('layouts')
summon = require('summon')
chain = require('chain')
require('window')


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
hs.grid.setGrid('60x20')
hs.grid.setMargins('25x25')

if (hs.screen.primaryScreen():name() == 'LG HDR WQHD') then
  hs.grid.setMargins('30x30')
end

hs.screen.watcher.new(function ()
  hs.reload()
end):start()


--------------------------------------------------------------------------------
-- Single Window Movements
--------------------------------------------------------------------------------
-- hl    side column movements
-- k     fullscreen and middle column movements
-- j     centered window movements
-- yu    top corner movements
-- nm    bottom corner movements
-- i     insert/snap to nearest grid region

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
  -- ['i'] = function() hs.grid.snap(hs.window.focusedWindow()) end, -- seems buggy?
}

registerKeyBindings(bigHyper, hs.fnutils.map(singleWindowMovements, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- Multi Window Management
--------------------------------------------------------------------------------
-- hjkl  focus window west/south/north/east
-- a     unide [a]ll application windows
-- p     [p]ick layout
-- y     [y]eet window from layout
-- o     [o]nly window, like `o` in vim
-- m     [m]aximize window
-- n     [n]ext window in current cell, like `n/p` in vim
-- u     warp [u]nder another window cell
-- .     [.] to save this layout
-- /     [/] to slash changes / reset current layout

local windowManagementBindings = {
  ['h'] = function() hs.window.focusedWindow():focusWindowWest(nil, true) end,
  ['j'] = function() hs.window.focusedWindow():focusWindowSouth(nil, true) end,
  ['k'] = function() hs.window.focusedWindow():focusWindowNorth(nil, true) end,
  ['l'] = function() hs.window.focusedWindow():focusWindowEast(nil, true) end,
  ['a'] = function() hs.application.frontmostApplication():unhide() end,
  ['p'] = openLayoutSelector,
  ['y'] = removeWindowFromLayout,
  ['o'] = toggleFocusMode,
  ['m'] = toggleMaximized,
  ['n'] = focusNextCellWindow,
  ['u'] = warpToExistingCellPosition,
  ['.'] = saveLayoutSnapshot,
  [';'] = toggleAlternateLayout,
  ['/'] = resetLayout,
  -- [?] = warpToDefaultPosition, -- Do I want this?
  -- [?] = hideFloatingWindows, -- Do I want this?
}

registerKeyBindings(hyper, hs.fnutils.map(windowManagementBindings, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
