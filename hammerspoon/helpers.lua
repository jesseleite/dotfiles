--------------------------------------------------------------------------------
-- Application Helpers
--------------------------------------------------------------------------------

function appIs(name)
    return hs.application.frontmostApplication():name() == name
end


--------------------------------------------------------------------------------
-- Modal Helpers
--------------------------------------------------------------------------------

function activateModal(mods, key, timeout)
  timeout = timeout or false
  local modal = hs.hotkey.modal.new(mods, key)
  local timer
  modal:bind('', 'escape', nil, function() modal:exit() end)
  modal:bind('', 'q', nil, function() modal:exit() end)
  modal:bind('ctrl', 'c', nil, function() modal:exit() end)
  function modal:entered()
    if timeout then
      timer = hs.timer.doAfter(3, function() modal:exit() end)
    end
    print('modal entered')
  end
  function modal:exited()
    if timer then
      timer:stop()
    end
    print('modal exited')
  end
  return modal
end

function modalBind(modal, key, fn, exitAfter)
  exitAfter = exitAfter or false
  modal:bind('', key, nil, function()
    fn()
    if exitAfter then
      modal:exit()
    end
  end)
end


--------------------------------------------------------------------------------
-- Yabai Helpers
--------------------------------------------------------------------------------

function yabaiCmd(cmd, fallbackCmd)
  hs.task.new('/usr/local/bin/yabai', function(exitCode)
    if exitCode == 1 then
      yabaiCmd(fallbackCmd)
    end
  end, hs.fnutils.concat({'-m'}, cmd)):start()
end

function yabai(binding, fallbackCmd)
  if type(binding) == 'string' then
    return yabaiRunFromString(binding)
  elseif type(binding) == 'table' then
    return yabaiCmd(binding, fallbackCmd)
  elseif type(binding) == 'function' then
    return binding()
  else
    print('incompatible binding type')
  end
end

function yabaiRunFromString(binding)
  if string.match(binding, 'OR') then
    local cmds = hs.fnutils.map(hs.fnutils.split(binding, ' OR '), function(cmd)
      return hs.fnutils.split(cmd, ' ');
    end)
    yabaiCmd(cmds[1], cmds[2])
  elseif string.match(binding, 'AND') then
    hs.fnutils.each(hs.fnutils.split(binding, ' AND '), function(cmd)
      yabaiCmd(hs.fnutils.split(cmd, ' '))
      print(hs.inspect(hs.fnutils.split(cmd, ' ')))
    end)
  else
    yabaiCmd(hs.fnutils.split(binding, ' '))
  end
end


--------------------------------------------------------------------------------
-- Binding Helpers
--------------------------------------------------------------------------------

function registerKeyBindings(mods, bindings)
  for key,binding in pairs(bindings) do
    hs.hotkey.bind(mods, key, binding)
  end
end

function registerModalBindings(mods, key, bindings, exitAfter)
  exitAfter = exitAfter or false
  local timeout = exitAfter == true
  local modal = activateModal(mods, key, timeout)
  for modalKey,binding in pairs(bindings) do
    modalBind(modal, modalKey, binding, exitAfter)
  end
  return modal
end
