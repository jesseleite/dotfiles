-----------------------------------------------
-- This is a mess!  You should probably close your eyes.
-----------------------------------------------

hs.window.animationDuration = 0

hs.grid.setMargins({w=10, h=10})

hs.hotkey.bind({"cmd", "ctrl"}, "space", function()
    hs.grid.show()
end)

positions = {
  maximized = hs.layout.maximized,

  centered = {x=0.3, y=0.15, w=0.4, h=0.7},
  centeredTall = {x=0.3, y=0.05, w=0.4, h=0.9},
  centeredWide = {x=0.25, y=0.15, w=0.5, h=0.7},

  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},

  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5}
}

function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "ctrl"}, key, fn)
end

grid = {
  {key="f", units={positions.maximized}},
  {key="c", units={positions.centered, positions.centeredTall, positions.centeredWide}},

  {key="h", units={positions.left50, positions.left66, positions.left34}},
  {key="j", units={positions.lower50}},
  {key="k", units={positions.upper50}},
  {key="l", units={positions.right50, positions.right66, positions.right34}},

  {key="y", units={positions.upper50Left50}},
  {key="u", units={positions.upper50Right50}},
  {key="b", units={positions.lower50Left50}},
  {key="n", units={positions.lower50Right50}},
}

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
      return windowGeo:equals(geo)
    end)
    if index == #units then index = 0 end

    window:moveToUnit(units[index + 1])
  end)
end)

bindKey('1', function()
  hs.layout.apply({
    {"Google Chrome", nil, screen, positions.right34,        nil, nil},
    {"Hyper",         nil, screen, positions.centered,       nil, nil},
    {"Slack",         nil, screen, positions.lower50Left50,  nil, nil}
  })
end)

-----------------------------------------------
-- Hyper hjkl to switch window focus
-----------------------------------------------

local hyper = {"cmd", "shift"}

hs.hotkey.bind(hyper, 'k', function()
    hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind(hyper, 'j', function()
    hs.window.focusedWindow():focusWindowSouth()
end)

hs.hotkey.bind(hyper, 'l', function()
    hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind(hyper, 'h', function()
    hs.window.focusedWindow():focusWindowWest()
end)
