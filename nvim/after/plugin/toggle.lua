--------------------------------------------------------------------------------
-- Toggle Helpers
--------------------------------------------------------------------------------

local toggleTimer = vim.uv.new_timer()

local useTwo = false

QuickToggleCallbacks = function (callbackOne, callbackTwo)
  if useTwo then
    callbackTwo()
    useTwo = false
  else
    callbackOne()
    useTwo = true
  end

  toggleTimer:start(3000, 0, function ()
    toggleTimer:stop()
    useTwo = false
  end)
end
