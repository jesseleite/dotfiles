--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------

-- Sometimes 1password lock screen opens behind other windows
hs.window.filter.new():subscribe(hs.window.filter.windowCreated, function(window)
  if window:title() == 'Lock Screen — 1Password' then
    window:focus()
  end
end)

-- -- This needs to be assigned to global var to work!?
-- play_key_watcher = hs.eventtap.new({hs.eventtap.event.types.systemDefined}, function(e)
--   if e:systemKey().key == 'PLAY' and e:systemKey().down then
--     print('playing')
--     -- Not sure we can disable the default behaviour here though,
--     -- But if we could, we can use either one of these to control itunes directly...
--     hs.itunes.playpause()
--     -- osascript -e "tell app \"Music\" to playpause"
--   end
-- end):start()

-- hs.screen.watcher.new(function ()
--   hs.reload()
-- end):start()

-- Specifically for recording vim gifs on retina
hs.hotkey.bind(hyper, 'g', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.w = 1200
  f.h = 850
  win:setFrameInScreenBounds(f)
end)

-- -- Video stuff
-- hs.hotkey.bind(hyper, 'v', chain({'1,3 14x13'}))
-- hs.hotkey.bind(hyper, 't', chain({'15,3 14x13'}))
hs.hotkey.bind(hyper, 'q', function()
  hs.window.focusedWindow():setFrame({x = 62, y = 220, w = 1920, h = 1080})
end)

--------------------------------------------------------------------------------
-- Cal Newport Mode
--------------------------------------------------------------------------------

hs.hotkey.bind(bigHyper, '\\', function()
  print('hoteked')
  local nop = 'F24'
  apps.Telegram.summon = nop
  apps.Discord.summon = nop
end)


--------------------------------------------------------------------------------
-- Normalize Hotkey Bindings
--------------------------------------------------------------------------------

-- hs.timer.doAfter(0.5, function()
--   hs.eventtap.keyStroke({'ctrl', 'shift'}, 'left')
--   print('wat')
-- end)

-- hs.hotkey.bind({'cmd'}, 'k', function()
--   if appIs('Brave Browser') then
--     print('Yep, it is Brave')
--   elseif appIs('Discord') then
--     print('Yep, it is Discord')
--   end
-- end)
