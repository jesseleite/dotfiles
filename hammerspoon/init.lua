--------------------------------------------------------------------------------
-- Global Config
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"}
lilHyper = {"cmd", "ctrl"}
bigHyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, '`', hs.toggleConsole)

require('summon')
require('helpers')
require('area51')

local chain = require('chain')


--------------------------------------------------------------------------------
-- Summon Alacritty Terminal
--------------------------------------------------------------------------------

hs.hotkey.bind({"cmd"}, "escape", function()
  summon('Alacritty')
  setLayout()
end)


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
hs.grid.setMargins('36x36')

positions = {
  full     = '0,0 30x20',

  center = {
    wide   = '2,1 26x18',
    normal = '6,1 18x18',
    narrow = '10,1 10x18',
  },

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
hs.hotkey.bind(hyper, 'c', chain({positions.center.normal, positions.center.wide, positions.center.narrow}))

local chainX = { 'thirds', 'halves', 'twoThirds', }
local chainY = { 'thirds', 'full' }

hs.hotkey.bind(hyper, 'h', chain(getPositions(chainX, 'left')))
hs.hotkey.bind(hyper, 'j', chain(getPositions(chainY, 'center', 'bottom')))
hs.hotkey.bind(hyper, 'k', chain(getPositions(chainY, 'center', 'top')))
hs.hotkey.bind(hyper, 'l', chain(getPositions(chainX, 'right')))
hs.hotkey.bind(hyper, 'y', chain(getPositions(chainX, 'left', 'top')))
hs.hotkey.bind(hyper, 'u', chain(getPositions(chainX, 'right', 'top')))
hs.hotkey.bind(hyper, 'b', chain(getPositions(chainX, 'left', 'bottom')))
hs.hotkey.bind(hyper, 'n', chain(getPositions(chainX, 'right', 'bottom')))
hs.hotkey.bind(hyper, 'm', chain(getPositions(chainY, 'center')))

hs.hotkey.bind(hyper, 's', function ()
  snap()
end)


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------
-- w: work layout
-- q: music and other secondary stuff
-- 0: disable current layout

currentLayout = nil

layouts = {

  w = function ()
    moveApp('Alacritty', positions.twoThirds.right)
    moveApp('Google Chrome', positions.thirds.left)
    moveApp('GitHub Desktop', positions.thirds.center)
    moveApp('Slack', '20,0 10x10')
    moveApp('Discord', '20,10 10x10')
  end,

  q = function ()
    moveApp('Music', '1,1 12x18')
    moveApp('Messages', '15,9 7x10')
    moveApp('Telegram', '14,9 6x9')
    moveApp('Discord', '21,2 8x11')
  end,

}

hs.hotkey.bind(hyper, 'w', function() setLayout('w', true) end)
hs.hotkey.bind(hyper, 'q', function() setLayout('q') end)
hs.hotkey.bind(hyper, '0', function() resetLayout() end)


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')

-- Wicked ideas from guys I should learn from...
-- https://aaronlasseigne.com/2016/02/16/switching-from-slate-to-hammerspoon/
-- https://github.com/jimeh/dotfiles/blob/master/hammerspoon/window_management.lua
-- https://wincent.com/wiki/Hammerspoon
