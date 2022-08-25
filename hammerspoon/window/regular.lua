currentLayout = nil
previousLayout = nil
currentLayoutConfiguration = nil

function startRegularMode()
    if (previousLayout == nil) then
        printi('starting regular mode and theres no previousLayout')
        currentLayout = { windows = {} }
    else
        currentLayout = previousLayout
        printi(currentLayout)
        positionWindows(currentLayout.windows)
    end

    previousLayout = nil
end

function stopRegularMode()
    previousLayout = currentLayout
    currentLayout = nil
end

function hideFloatingWindows()
    for _,window in pairs(hs.window.visibleWindows()) do
        if currentLayout.windows[window:id()] == nil then
            window:minimize()
        end
    end
end

function saveLayoutSnapshot()
    for _,window in pairs(hs.window.visibleWindows()) do
        if window:isStandard() then -- Avoid moving dialogs, etc.
            currentLayout.windows[window:id()] = window:frame()
        end
    end
end

function resetLayout()
    if (currentMode == 'focus') then
        setWindowMode('regular')
    end

    if not currentLayout.windows then
        return
    end

    positionWindows(currentLayout.windows)
    hideFloatingWindows()
end

function positionWindows(windows)
    for id,frame in pairs(windows) do
        local window = hs.window.find(id)
        if window then
            positionWindowUsingRect(window, frame)
        end
    end
end

function removeWindowFromLayout()
  local win = hs.window.focusedWindow()
  if currentLayout.windows[win:id()] then
      currentLayout.windows[win:id()] = nil
  end
end


function openLayoutSelector()
  local choices = hs.fnutils.map(layouts, function(layout)
    return {
      ["text"] = layout.name,
      ["subText"] = layout.description,
      ["layout"] = layout
    }
  end)

  local chooser = hs.chooser.new(function(choice)
      setWindowMode('regular')
      applyPresetLayout(choice.layout)
  end)

  chooser:searchSubText(true):choices(choices):query(''):show()
end

function applyPresetLayout(layout)
    currentLayout = { windows = {} }
    currentLayoutConfiguration = 1
    for app,options in pairs(layout.apps) do
        positionAppUsingGrid(app, layout.cells[options.cell][1], options.open)
    end
    currentLayout.preset = layout
    hideWindowsExcept(tableKeys(layout.apps))
    saveLayoutSnapshot()
end

function toggleAlternateLayout()
    if currentLayout == nil then return end
    currentLayoutConfiguration = currentLayoutConfiguration + 1
    for app,options in pairs(currentLayout.preset.apps) do
        local cells = currentLayout.preset.cells[options.cell]
        if cells[currentLayoutConfiguration] == nil then currentLayoutConfiguration = 1 end
        positionAppUsingGrid(app, cells[currentLayoutConfiguration])
    end
    saveLayoutSnapshot()
end
