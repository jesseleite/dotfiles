--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"} -- or D+F 🤘
bigHyper = {"shift", "cmd", "alt", "ctrl"} -- or S+D+F 😅

hs.loadSpoon("ReloadConfiguration"):start()

require('summon')
require('helpers')
require('area51')

apps = require('apps')

-- require('windows')
-- require('modals')
-- positions = require('positions')
-- layouts = require('layouts')


--------------------------------------------------------------------------------
-- Summon Specific Apps
--------------------------------------------------------------------------------

hs.fnutils.each(apps, function(app)
  if app.summon then
    hs.hotkey.bind(app.summon[1], app.summon[2], function() summon(app.id) end)
  end
end)

local summonModalBindings = flipTable(hs.fnutils.map(apps, function(app)
  return app.summonModal
end))

registerModalBindings(hyper, 'space', hs.fnutils.map(summonModalBindings, function(app)
  return function() summon(app) end
end), true)


--------------------------------------------------------------------------------
-- Window Management
--------------------------------------------------------------------------------

-- hs.window.animationDuration = 0.2
-- hs.grid.setGrid('30x20')
-- hs.grid.setMargins('30x30')

-- -- Grid Movements
-- local chain = require('chain')
-- local chainX = { 'thirds', 'halves', 'twoThirds', 'fiveSixths', 'sixths', }
-- local chainY = { 'thirds', 'full' }
-- local centers = positions.center
-- bindHyper('up', chain({positions.full, centers.large, centers.medium, centers.small, centers.tiny}))
-- bindHyper('left', chain(getPositions(chainX, 'left')))
-- bindHyper('right', chain(getPositions(chainX, 'right')))
-- bindHyper('down', chain(getPositions(chainY, 'center')))

-- -- Multi-window layouts
-- bindLayoutSelector('l')
-- bindPositionSelector('return')
-- bindHyper('r', resetLayout)
-- bindHyper('h', hideFloatingWindows)
-- bindHyper('s', function ()
--     saveLayoutSnapshot()
--     hs.alert.show('Layout snapshotted')
-- end)
-- bindHyper('delete', function ()
--     removeWindowFromLayout(hs.window.focusedWindow())
--     hs.alert.show("Window removed from layout")
-- end)
-- bindHyper('m', toggleMaximized)
-- bindHyper('d', setToDefaultPosition)
-- bindHyper('t', toggleLayout)
-- bindHyper('c', cycleLayouts)
-- bindWarp('w')
-- bindHyper('n', focusNextCellWindow)
-- bindHyper('p', focusPreviousCellWindow)
-- bindHyper('f', toggleFocusMode)

local hyperBindings = {
  ['h'] = function() hs.window.focusedWindow():focusWindowWest(nil, true) end,
  ['j'] = function() hs.window.focusedWindow():focusWindowSouth(nil, true) end,
  ['k'] = function() hs.window.focusedWindow():focusWindowNorth(nil, true) end,
  ['l'] = function() hs.window.focusedWindow():focusWindowEast(nil, true) end,
  -- ['o'] = focus mode
  -- ['m'] = maximize
}

registerKeyBindings(hyper, hs.fnutils.map(hyperBindings, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
