hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window)
  local f = window:frame()
  printi({
    Focused = {
      ['App Name'] = window:application():name(),
      ['Bundle ID'] = window:application():bundleID(),
      ['Window Title'] = window:title(),
      ['Window ID'] = window:id(),
      ['Window Frame'] = string.format("{x=%s,y=%s,w=%s,h=%s}", f._x, f._y, f._w, f._h),
    }
  })
end)
