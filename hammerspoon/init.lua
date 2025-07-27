--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

hyper = {'cmd', 'alt', 'ctrl'} -- or D+F 🤘
bigHyper = {'shift', 'cmd', 'alt', 'ctrl'} -- or S+D+F 😅

hs.loadSpoon('ReloadConfiguration'):start()

require('helpers')
require('area51')

positions = require('positions')
apps = require('apps')
layouts = require('layouts')
summon = require('summon')
chain = require('chain')

local layout = hs.loadSpoon('GridLayout')
local paper = hs.loadSpoon('PaperWM')


--------------------------------------------------------------------------------
-- Global Window Settings
--------------------------------------------------------------------------------

hs.window.animationDuration = 0

local gap

if (hs.screen.primaryScreen():name() == 'LG HDR WQHD') then
  gap = 30
elseif (hs.screen.primaryScreen():name() == '24GL600F') then
  gap = 12
else
  gap = 15
end


--------------------------------------------------------------------------------
-- Summon Specific Apps
--------------------------------------------------------------------------------
-- F13 to open summon modal
-- See `apps.lua` for `summon` modal bindings

local summonModalBindings = tableFlip(hs.fnutils.map(apps, function(app)
  return app.summon
end))

registerModalBindings(nil, 'f13', hs.fnutils.map(summonModalBindings, function(app)
  return function() summon(app) end
end), true)


--------------------------------------------------------------------------------
-- Misc Macros
--------------------------------------------------------------------------------
-- F14 to open macros modal

local macros = {
  s = function() hs.eventtap.keyStroke({'cmd', 'shift'}, '4') end, -- screenshot
  e = function() hs.eventtap.keyStroke({'cmd', 'ctrl'}, 'space') end, -- emoji picker
  a = function() hs.eventtap.keyStroke({'cmd'}, '`') end, -- next window of focused app
  c = function() hs.eventtap.keyStroke({'cmd', 'ctrl'}, 'c') end, -- color picker app
  x = function() hs.eventtap.keyStroke({'cmd', 'ctrl'}, 'x') end, -- color picker eye dropper
}

registerModalBindings(nil, 'f14', macros, true)


--------------------------------------------------------------------------------
-- Multi Window Management
--------------------------------------------------------------------------------
-- hjkl  focus window west/south/north/east
-- a     unide [a]ll application windows
-- p     [p]ick layout
-- m     [m]aximize window
-- n     [n]ext window in current cell, like `n/p` in vim
-- u     warp [u]nder another window cell
-- ;     toggle alternate layout

layout
  :start()
  :setLayouts(layouts)
  :setApps(apps)
  :setGrid('60x20')
  :setMargins(gap..'x'..gap)

paper.window_gap = gap

local selectLayout = function ()
  local choices = layout:all()

  table.insert(choices, 1, {
    text = 'Tiled Scrollable Window Manager',
    key = 'scrollable',
  })

  local chooser = hs.chooser.new(function(choice)
    paper:stop()
    if choice.key == 'scrollable' then
      paper:start()
    else
      layout:selectLayout(choice.key)
    end
  end)

  chooser:searchSubText(true):choices(choices):query(''):show()
end

local windowManagementBindings = {
  ['p'] = selectLayout,
  ['h'] = function() hs.window.focusedWindow():focusWindowWest(nil, true) end,
  ['j'] = function() hs.window.focusedWindow():focusWindowSouth(nil, true) end,
  ['k'] = function() hs.window.focusedWindow():focusWindowNorth(nil, true) end,
  ['l'] = function() hs.window.focusedWindow():focusWindowEast(nil, true) end,
  ['a'] = function() hs.application.frontmostApplication():unhide() end,
  ['u'] = layout.bindToCell,
  [';'] = layout.selectNextVariant,
  ["'"] = layout.resetLayout,
  -- ['m'] = toggleMaximized, -- Re-implement in GridLayout?
  -- ['n'] = focusNextCellWindow, -- Re-implement in GridLayout?
}

registerKeyBindings(hyper, hs.fnutils.map(windowManagementBindings, function(fn)
  return function() fn() end
end))


--------------------------------------------------------------------------------
-- Tiled Scrollable WM Specific Bindings
--------------------------------------------------------------------------------

paper:bindHotkeys({
  swap_left        = { bigHyper, "h" },
  decrease_width   = { bigHyper, "j" },
  increase_width   = { bigHyper, "k" },
  swap_right       = { bigHyper, "l" },
  slurp_in         = { bigHyper, "i" },
  barf_out         = { bigHyper, "o" },
  full_width       = { bigHyper, "m" },
  toggle_floating  = { bigHyper, "u" },
  -- swap_down     = do i need this?
  -- swap_up       = do i need this?
  -- move_window_1 = move window to space 1?
  -- move_window_2 = move window to space 2?
  -- move_window_3 = move window to space 3?
})


--------------------------------------------------------------------------------
-- Single Window Movements
--------------------------------------------------------------------------------
-- hl    side column movements
-- k     fullscreen and middle column movements
-- j     centered window movements
-- yu    top corner movements
-- nm    bottom corner movements
-- i     insert/snap to nearest grid region

-- local chainX = { 'thirds', 'halves', 'twoThirds', 'fiveSixths', 'sixths' }
-- local chainY = { 'full', 'thirds' }
--
-- local singleWindowMovements = {
--   ['h'] = chain(getPositions(chainX, 'left')),
--   ['k'] = chain(getPositions(chainY, 'center')),
--   ['j'] = chain({ positions.center.large, positions.center.medium, positions.center.small, positions.center.tiny, positions.center.mini }),
--   ['l'] = chain(getPositions(chainX, 'right')),
--   ['y'] = chain(getPositions(chainX, 'left', 'top')),
--   ['u'] = chain(getPositions(chainX, 'right', 'top')),
--   ['n'] = chain(getPositions(chainX, 'left', 'bottom')),
--   ['m'] = chain(getPositions(chainX, 'right', 'bottom')),
--   -- ['i'] = function() hs.grid.snap(hs.window.focusedWindow()) end, -- seems buggy?
-- }
--
-- registerKeyBindings(bigHyper, hs.fnutils.map(singleWindowMovements, function(fn)
--   return function() fn() end
-- end))


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')
