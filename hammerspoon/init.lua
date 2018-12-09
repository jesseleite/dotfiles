--------------------------------------------------------------------------------
-- Global Hammerspoon Config
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"}
lilHyper = {"cmd", "ctrl"}
bigHyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

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
hs.grid.setMargins({x=16, y=16})

positions = {

  spacious = {
    center       = '5,3 15x12',
    left         = '4,2 10x16',
    right        = '16,2 10x16',
  },

  thirds = {
    left         = '0,0 10x20',
    leftTop      = '0,0 10x10',
    leftBottom   = '0,10 10x10',
    center       = '10,0 10x20',
    centerTop    = '10,0 10x10',
    centerBottom = '10,10 10x10',
    right        = '20,0 10x20',
    rightTop     = '20,0 10x10',
    rightBottom  = '20,10 10x10',
  },

  halves = {
    left         = '0,0 15x20',
    right        = '15,0 15x20',
  },

}


--------------------------------------------------------------------------------
-- Window Movements
--------------------------------------------------------------------------------

hs.hotkey.bind(hyper, 'h', chain({
  positions.thirds.left,
  positions.halves.left,
  positions.spacious.left,
}))

hs.hotkey.bind(hyper, 'l', chain({
  positions.thirds.right,
  positions.halves.right,
  positions.spacious.right,
}))

hs.hotkey.bind(lilHyper, 's', function ()
  snap()
end)


--------------------------------------------------------------------------------
-- Multi Window Layouts
--------------------------------------------------------------------------------

-- Just editor and browser
hs.hotkey.bind(hyper, '1', function()
  moveApp('Hyper', positions.spacious.left)
  moveApp('Google Chrome', positions.spacious.right)
end)

-- All the things
hs.hotkey.bind(hyper, '2', function()
  moveApp('Hyper', positions.thirds.center)
  moveApp('Google Chrome', positions.thirds.right)
  moveApp('GitHub Desktop', positions.thirds.center)
  moveApp('Slack', positions.thirds.leftTop)
  moveApp('Discord', positions.thirds.leftBottom)
end)


--------------------------------------------------------------------------------
-- Switch Focus
--------------------------------------------------------------------------------

hs.hotkey.bind(lilHyper, 'k', function()
  hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind(lilHyper, 'j', function()
  hs.window.focusedWindow():focusWindowSouth()
end)

hs.hotkey.bind(lilHyper, 'l', function()
  hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind(lilHyper, 'h', function()
  hs.window.focusedWindow():focusWindowWest()
end)


--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

function moveApp(application, cell)
  local window = hs.window.find(application)
  if (window) then
    hs.grid.set(window, cell, hs.screen.mainScreen())
  end
end

function snap()
  local window = hs.window.focusedWindow()
  hs.grid.snap(window)
  print(hs.inspect(hs.grid.get(window)))
end


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
