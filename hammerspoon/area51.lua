--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------

-- Specifically for recording vim gifs on retina
hs.hotkey.bind(hyper, 'g', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.w = 1200
  f.h = 850
  win:setFrameInScreenBounds(f)
end)
