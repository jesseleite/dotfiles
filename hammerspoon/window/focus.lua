focusWindowFilter = hs.window.filter.new()

function startFocusMode()
    subscribeToFocusWindowEvents()
    applyFocusPosition(hs.window.focusedWindow())
end

function stopFocusMode()
    focusWindowFilter:unsubscribeAll()
end

function subscribeToFocusWindowEvents()
    -- Subscribe to windows being focused.
    -- This would happen when you manually focus a window, or when
    -- you close another app and a different app becomes focused.
    focusWindowFilter:subscribe(hs.window.filter.windowFocused, function(win)
        applyFocusPosition(win)
    end)
end

function applyFocusPosition(win)
    -- Determine the cell to use for the window. It could be defined in apps.lua.
    local cell = positions.center.medium -- Default
    local app = win:application()
    local config = hs.fnutils.find(apps, function(config) return config.id == app:bundleID() end)
    if config and config.position then cell = config.position end
    if config and config.focus then cell = config.focus end

    -- Apply the cell position to all visible windows
    local windows = hs.window.visibleWindows()
    for _,win in pairs(windows) do
        if (win:isStandard()) then -- Avoid moving dialogs, etc.
            positionWindowUsingGrid(win, cell)
        end
    end

    -- Clear out any maximized windows as they'd now be repositioned.
    -- Otherwise, when you go back that window and tried to re-maximize it,
    -- it'd think it was already maximized and would act like nothing happened.
    maximizedWindows = {}
end
