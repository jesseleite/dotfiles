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
  leftThird         = {x=0, y=0, w=10, h=20},
  leftThirdTop      = {x=0, y=0, w=10, h=10},
  leftThirdBottom   = {x=0, y=10, w=10, h=10},
  centerThird       = {x=10, y=0, w=10, h=20},
  centerThirdTop    = {x=10, y=0, w=10, h=10},
  centerThirdBottom = {x=10, y=10, w=10, h=10},
  rightThird        = {x=20, y=0, w=10, h=20},
  rightThirdTop     = {x=20, y=0, w=10, h=10},
  rightThirdBottom  = {x=20, y=10, w=10, h=10},
}


-----------------------------------------------
-- Layouts
-----------------------------------------------

hs.hotkey.bind(lilHyper, '1', function()
  local screen = hs.screen.mainScreen()
  hs.layout.apply({
    {"Google Chrome", nil, screen, gridCellToUnitRect(positions.rightThird, screen),      nil, nil},
    {"Hyper",         nil, screen, gridCellToUnitRect(positions.centerThird, screen),     nil, nil},
    {"Slack",         nil, screen, gridCellToUnitRect(positions.leftThirdTop, screen),    nil, nil},
    {"Discord",       nil, screen, gridCellToUnitRect(positions.leftThirdBottom, screen), nil, nil},
  })
end)

function gridCellToUnitRect(cell, screen)
  return hs.geometry.toUnitRect(hs.grid.getCell(cell, screen), screen:frame())
end


-----------------------------------------------
-- Hjkl to switch window focus
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


-----------------------------------------------
-- The End
-----------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
