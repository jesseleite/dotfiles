-- https://github.com/Hammerspoon/hammerspoon/issues/2943
hs.window.filter.ignoreAlways['Safari Web Content (Cached)'] = true

-- Subscribe to windows being closed. If the app has no visible windows, hide the app.
hs.window.filter.new():subscribe(hs.window.filter.hasNoWindows, function(win)
    -- Some apps with a window leftover still sometimes trigger the hasNoWindows
    -- event. We'll need to check if there are windows instead of just hiding.
    local app = win:application()
    if #app:allWindows() == 0 then app:hide() end
end)

-- Subscribe to windows being created in order to automatically place them in the correct layout.
hs.window.filter.new():subscribe(hs.window.filter.windowCreated, function(win)
    -- Avoid moving dialogs, etc.
    -- Also avoid when dragging a tab out of the browser into a new window, etc.
    if win:isStandard() and not hs.mouse.getButtons().left then
        addWindowToLayoutCell(win)
    end
end)
