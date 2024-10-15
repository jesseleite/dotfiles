--------------------------------------------------------------------------------
-- Toggle Screenshot Mode (thanks @sixlive!)
--------------------------------------------------------------------------------

local enabled = false

local initial = {
  number = vim.opt.number,
  relativenumber = vim.opt.relativenumber,
  signcolumn = vim.opt.signcolumn,
  cursorline = vim.opt.cursorline,
}

local flip = function (opt, enabledValue)
  if enabled then
    vim.opt[opt] = enabledValue
  else
    vim.opt[opt] = initial[opt]
  end
end

vim.keymap.set('n', '<Leader><Leader>s', function ()
  if enabled then
    enabled = false
  else
    enabled = true
  end

  flip('number', false)
  flip('number', false)
  flip('relativenumber', false)
  flip('signcolumn', 'yes:2')
  flip('cursorline', false)

  if enabled then
    vim.diagnostic.disable()
  else
    vim.diagnostic.enable()
  end
end)
