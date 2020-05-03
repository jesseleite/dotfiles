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

-- Open tests in new hyper window
hs.hotkey.bind(hyper, 't', function ()
  hs.focus()
  local button,zArg = hs.dialog.textPrompt('Where would you like to run tests?', 'Specify z-compatible jump target:')
  hs.application.launchOrFocus('Hyper')
  moveCurrentWindow(positions.twoThirds.right)
  sleep(500)
  hs.application.frontmostApplication():selectMenuItem({'Shell', 'New Window'})
  sleep(500)
  moveCurrentWindow(positions.thirds.left)
  hs.eventtap.keyStrokes('in ' .. zArg .. ' shtuff as test')
  hs.eventtap.keyStroke({}, 'return')
  hs.window.switcher.nextWindow()
end)
