-- Define Hyper Modifiers
hyper = {"cmd", "alt", "ctrl"}
lilHyper = {"cmd", "ctrl"}
bigHyper = {"cmd", "alt", "ctrl", "shift"}

-- Hammerspoon Meta Mappings
hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

-- Spoon Installer?
-- hs.loadSpoon("SpoonInstall")

-- Wicked ideas from guys I should learn from...
-- https://aaronlasseigne.com/2016/02/16/switching-from-slate-to-hammerspoon/
-- https://github.com/jimeh/dotfiles/blob/master/hammerspoon/window_management.lua


-----------------------------------------------
-- Global Window Management Settings
-----------------------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid('30x20')
hs.grid.setMargins({x=16, y=16})

positions = {
  spacious = {
    center       = {x=5, y=3, w=15, h=12},
    left         = {x=4, y=2, w=10, h=16},
    right        = {x=16, y=2, w=10, h=16},
  },
  thirds = {
    left         = {x=0, y=0, w=10, h=20},
    leftTop      = {x=0, y=0, w=10, h=10},
    leftBottom   = {x=0, y=10, w=10, h=10},
    center       = {x=10, y=0, w=10, h=20},
    centerTop    = {x=10, y=0, w=10, h=10},
    centerBottom = {x=10, y=10, w=10, h=10},
    right        = {x=20, y=0, w=10, h=20},
    rightTop     = {x=20, y=0, w=10, h=10},
    rightBottom  = {x=20, y=10, w=10, h=10},
  },
}


-----------------------------------------------
-- Multi Window Layouts
-----------------------------------------------

-- Just editor and browser
hs.hotkey.bind(lilHyper, '1', function()
  moveApp('Hyper', positions.spacious.left)
  moveApp('Google Chrome', positions.spacious.right)
end)

-- All the things
hs.hotkey.bind(lilHyper, '2', function()
  moveApp('Hyper', positions.thirds.center)
  moveApp('Google Chrome', positions.thirds.right)
  moveApp('GitHub Desktop', positions.thirds.center)
  moveApp('Slack', positions.thirds.leftTop)
  moveApp('Discord', positions.thirds.leftBottom)
end)


-----------------------------------------------
-- Focus Window
-----------------------------------------------

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

hs.hotkey.bind(lilHyper, 's', function()
  local window = hs.window.focusedWindow()
  hs.grid.snap(window)
  print(hs.inspect(hs.grid.get(window)))
end)


-----------------------------------------------
-- Helpers
-----------------------------------------------

function moveApp(application, cell)
  local window = hs.window.find(application)
  if (window) then
    hs.grid.set(window, cell, hs.screen.mainScreen())
  end
end


-----------------------------------------------
-- The End
-----------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
