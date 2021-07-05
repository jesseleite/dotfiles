--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

hyper = {"cmd", "alt", "ctrl"} -- or D+F 🤘

require('summon')
require('helpers')
require('area51')

hs.loadSpoon("ReloadConfiguration"):start()

hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, '`', hs.toggleConsole)


--------------------------------------------------------------------------------
-- Summon Specific Apps
--------------------------------------------------------------------------------

hs.hotkey.bind({'cmd'}, 'escape', function() summon('kitty') end)

local summonModalBindings = {
  k = 'kitty',
  c = 'Google Chrome',
  s = 'Slack',
  d = 'Discord',
  t = 'Tower',
  r = 'Ray',
  b = 'Bear',
  m = 'Music',
  e = 'Mimestream',
  f = 'Finder',
}

registerModalBindings(hyper, 'space', hs.fnutils.map(summonModalBindings, function(app)
  return function() summon(app) end
end), true)


--------------------------------------------------------------------------------
-- Yabai Window Management
--------------------------------------------------------------------------------

local yabaiKeyBindings = {
  ['h'] = 'window --focus west',
  ['j'] = 'window --focus south',
  ['k'] = 'window --focus north',
  ['l'] = 'window --focus east',
  ['n'] = 'window --focus stack.next OR window --focus stack.first',
  ['p'] = 'window --focus stack.prev OR window --focus stack.last',
  ['o'] = 'window --toggle zoom-parent',
  ['m'] = 'window --toggle zoom-fullscreen',
  [']'] = 'space --focus next',
  ['['] = 'space --focus prev',
  ['0'] = 'space --balance',
  ['-'] = 'window --resize left:50:0 AND window --resize right:-50:0',
  ['='] = 'window --resize left:-50:0 AND window --resize right:50:0',
  ['i'] = function() stackline.config:toggle('appearance.showIcons') end,
}

local yabaiModalBindings = {
  ['h'] = 'window --warp west',
  ['j'] = 'window --warp south',
  ['k'] = 'window --warp north',
  ['l'] = 'window --warp east',
  ['n'] = 'window --stack next',
  ['p'] = 'window --stack prev',
  ['f'] = 'window --toggle float',
  ['s'] = 'window --toggle split',
  ['o'] = 'window --toggle zoom-parent',
  ['m'] = 'window --toggle zoom-fullscreen',
  [']'] = 'space --focus next',
  ['['] = 'space --focus prev',
  ['0'] = 'space --balance',
  ['-'] = 'window --resize left:50:0 AND window --resize right:-50:0',
  ['='] = 'window --resize left:-50:0 AND window --resize right:50:0',
  ['i'] = function() stackline.config:toggle('appearance.showIcons') end,
  ['c'] = function() hs.window.focusedWindow():application():hide() end,
}

registerKeyBindings(hyper, hs.fnutils.map(yabaiKeyBindings, function(cmd)
  return function() yabai(cmd) end
end))

local yabaiModal = registerModalBindings(hyper, 'y', hs.fnutils.map(yabaiModalBindings, function(cmd)
  return function() yabai(cmd) end
end))

function yabaiModal:entered()
  hs.window.highlight.ui.overlay = true
  hs.window.highlight.ui.overlayColor = {0.5,0.25,0.75,0.25}
  hs.window.highlight.start()
end

function yabaiModal:exited()
  hs.window.highlight.stop()
end


--------------------------------------------------------------------------------
-- Yabai Stack Icons
--------------------------------------------------------------------------------

stackline = require('stackline')

stackline:init()

stackline.config:set('appearance.size', 23)
stackline.config:set('appearance.iconPadding', 1)
stackline.config:set('appearance.offset.x', 5)
stackline.config:set('appearance.offset.y', 12)
stackline.config:set('appearance.pillThinness', 4)
stackline.config:set('appearance.showIcons', false)


--------------------------------------------------------------------------------
-- The End
--------------------------------------------------------------------------------

hs.notify.show('Hammerspoon loaded', '', '...more like hammerspork')

-- Special thank you to Jose for all the rad Hammerspoon and Yabai ideas!
-- https://github.com/josecanhelp/dotfiles
