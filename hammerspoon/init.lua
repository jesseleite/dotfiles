--------------------------------------------------------------------------------
-- Global Hammerspoon Config
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"}
lilHyper = {"cmd", "ctrl"}
bigHyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

require('helpers')

-- 3rd party helpers that aren't spoons
local chain = require('chain')

-- Wicked ideas from guys I should learn from...
-- https://aaronlasseigne.com/2016/02/16/switching-from-slate-to-hammerspoon/
-- https://github.com/jimeh/dotfiles/blob/master/hammerspoon/window_management.lua
-- https://wincent.com/wiki/Hammerspoon


--------------------------------------------------------------------------------
-- Global Window Management Settings
--------------------------------------------------------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid('30x20')
local largeMargins = {x=16, y=16}
local smallMargins = {x=10, y=10}
hs.grid.setMargins(largeOrSmallScreen(largeMargins, smallMargins))

positions = {
  full           = '0,0 30x20',

  spacious = {
    center       = '8,2 14x16',
    left         = '4,2 10x16',
    right        = '16,2 10x16',
  },

  thirds = {
    left         = '0,0 10x20',
    center       = '10,0 10x20',
    right        = '20,0 10x20',
  },

  halves = {
    left         = '0,0 15x20',
    right        = '15,0 15x20',
  },

  twoThirds = {
    left        = '0,0 20x20',
    right       = '10,0 20x20',
  },

  fourFifths = {
    left        = '0,0 24x20',
    right       = '6,0 24x20',
  },

}


--------------------------------------------------------------------------------
-- Window Movements
--------------------------------------------------------------------------------

hs.hotkey.bind(lilHyper, 's', function ()
  snap()
end)

hs.hotkey.bind(hyper, 'f', chain({positions.full}))
hs.hotkey.bind(hyper, 'c', chain({positions.spacious.center, positions.spacious.left, positions.spacious.right}))

local largeX = { 'thirds', 'halves', 'twoThirds', 'spacious' }
local smallX = { 'halves', 'twoThirds', 'fourFifths' }

function bindGridMovements()
  hs.hotkey.bind(hyper, 'h', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left')))
  hs.hotkey.bind(hyper, 'l', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right')))
  hs.hotkey.bind(hyper, 'y', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left', 'top')))
  hs.hotkey.bind(hyper, 'u', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right', 'top')))
  hs.hotkey.bind(hyper, 'b', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left', 'bottom')))
  hs.hotkey.bind(hyper, 'n', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right', 'bottom')))
end

bindMovements()

hs.screen.watcher.newWithActiveScreen(function ()
  bindMovements()
end):start()


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------

-- Work
hs.hotkey.bind(hyper, 'w', function()
  moveApp('Hyper',          largeOrSmallScreen(positions.thirds.center, positions.full))
  moveApp('Google Chrome',  largeOrSmallScreen(positions.thirds.right, '4,0 26x20'))
  moveApp('Slack',          largeOrSmallScreen(positions.thirds.leftTop, '0,2 22x16'))
  moveApp('GitHub Desktop', largeOrSmallScreen(positions.thirds.center, '4,0 26x20'))
end)

-- Editing only
hs.hotkey.bind(hyper, 'e', function()
  moveApp('Hyper',          largeOrSmallScreen(positions.spacious.left, positions.full))
  moveApp('Google Chrome',  largeOrSmallScreen(positions.spacious.right, positions.full))
end)

-- ???
hs.hotkey.bind(hyper, '0', function()
  moveApp('iTunes', '1,1 12x18')
  moveApp('Messages', '15,9 7x10')
  moveApp('Discord', '20,1 9x11')
  moveApp('Terminal', '14,1 3x5') -- For iTunes-Discord npm helper
end)


--------------------------------------------------------------------------------
-- Switch Focus
--------------------------------------------------------------------------------

hs.hotkey.bind(lilHyper, 'k', function()
  hs.window.filter.focusNorth()
end)

hs.hotkey.bind(lilHyper, 'j', function()
  hs.window.filter.focusSouth()
end)

hs.hotkey.bind(lilHyper, 'l', function()
  hs.window.filter.focusEast()
end)

hs.hotkey.bind(lilHyper, 'h', function()
  hs.window.filter.focusWest()
end)


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
