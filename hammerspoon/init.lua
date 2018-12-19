--------------------------------------------------------------------------------
-- Global Config
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"}
lilHyper = {"cmd", "ctrl"}
bigHyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, '`', hs.toggleConsole)

require('helpers')

local chain = require('chain')


--------------------------------------------------------------------------------
-- Focus Window
--------------------------------------------------------------------------------

hs.hotkey.bind(lilHyper, 'h', function()
  hs.window.filter.focusWest()
end)

hs.hotkey.bind(lilHyper, 'j', function()
  hs.window.filter.focusSouth()
end)

hs.hotkey.bind(lilHyper, 'k', function()
  hs.window.filter.focusNorth()
end)

hs.hotkey.bind(lilHyper, 'l', function()
  hs.window.filter.focusEast()
end)


--------------------------------------------------------------------------------
-- Grid Settings
--------------------------------------------------------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid('30x20')

resetWhenSwitchingScreen(function ()
  hs.grid.setMargins(largeOrSmallScreen({x=16, y=16}, {x=10, y=10}))
end)

positions = {
  full     = '0,0 30x20',

  thirds = {
    left   = '0,0 10x20',
    center = '10,0 10x20',
    right  = '20,0 10x20',
  },

  halves = {
    left   = '0,0 15x20',
    right  = '15,0 15x20',
  },

  twoThirds = {
    left   = '0,0 20x20',
    right  = '10,0 20x20',
  },

  fourFifths = {
    left   = '0,0 24x20',
    center = '3,0 24x20',
    right  = '6,0 24x20',
  },
}


--------------------------------------------------------------------------------
-- Grid Movements
--------------------------------------------------------------------------------
-- f:    fullscreen
-- hjkl: edge movements
-- yu:   top corner movements
-- bn:   bottom corner movements
-- m:    middle column
-- s:    snap to nearest grid region

hs.hotkey.bind(hyper, 'f', chain({positions.full}))

local largeX = { 'thirds', 'halves', 'twoThirds', }
local smallX = { 'halves', 'twoThirds', 'fourFifths' }
local largeY = { 'thirds', 'full' }
local smallY = { 'fourFifths', 'full' }

resetWhenSwitchingScreen(function ()
  hs.hotkey.bind(hyper, 'h', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left')))
  hs.hotkey.bind(hyper, 'j', chain(getPositions(largeOrSmallScreen(largeY, smallY), 'center', 'bottom')))
  hs.hotkey.bind(hyper, 'k', chain(getPositions(largeOrSmallScreen(largeY, smallY), 'center', 'top')))
  hs.hotkey.bind(hyper, 'l', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right')))
  hs.hotkey.bind(hyper, 'y', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left', 'top')))
  hs.hotkey.bind(hyper, 'u', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right', 'top')))
  hs.hotkey.bind(hyper, 'b', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'left', 'bottom')))
  hs.hotkey.bind(hyper, 'n', chain(getPositions(largeOrSmallScreen(largeX, smallX), 'right', 'bottom')))
  hs.hotkey.bind(hyper, 'm', chain(getPositions(largeOrSmallScreen(largeY, smallY), 'center')))
end)

hs.hotkey.bind(lilHyper, 's', function ()
  snap()
end)


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------
-- w: standard work
-- e: editing only
-- 0: music and secondary chats

-- An idea...
-- If I tap one of these keys once, just move apps if they exist.
-- But if I tap a second time within 2 seconds, launch the unopened apps and hide the unessessary apps?

hs.hotkey.bind(hyper, 'w', function()
  moveApp('Hyper', largeOrSmallScreen(positions.thirds.center, positions.full))
  moveApp('Google Chrome', largeOrSmallScreen(positions.thirds.right, '4,0 26x20'))
  moveApp('GitHub Desktop', largeOrSmallScreen(positions.thirds.center, '4,0 26x20'))
  moveApp('Slack', largeOrSmallScreen('0,0 10x10', '0,2 22x16'))
  moveApp('Discord', largeOrSmallScreen('0,10 10x10', '0,2 22x16'))
end)

hs.hotkey.bind(hyper, 'e', function()
  moveApp('Hyper', largeOrSmallScreen('4,2 10x16', positions.full))
  moveApp('Google Chrome', largeOrSmallScreen('16,2 10x16', positions.full))
end)

hs.hotkey.bind(hyper, '0', function()
  moveApp('iTunes', '1,1 12x18')
  moveApp('Messages', '15,9 7x10')
  moveApp('Discord', '20,1 9x11')
  moveApp('Terminal', '14,1 3x5') -- For iTunes-Discord npm helper
end)


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')

-- Wicked ideas from guys I should learn from...
-- https://aaronlasseigne.com/2016/02/16/switching-from-slate-to-hammerspoon/
-- https://github.com/jimeh/dotfiles/blob/master/hammerspoon/window_management.lua
-- https://wincent.com/wiki/Hammerspoon
