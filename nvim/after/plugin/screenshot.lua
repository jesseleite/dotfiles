--------------------------------------------------------------------------------
-- Toggle Screenshot Mode (thanks @sixlive!)
--------------------------------------------------------------------------------

local enabled = false

local initial = {
  number = vim.opt.number,
  relativenumber = vim.opt.relativenumber,
  signcolumn = vim.opt.signcolumn,
  cursorline = vim.opt.cursorline,
  laststatus = vim.opt.laststatus,
  cmdheight = vim.opt.cmdheight,
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
  flip('signcolumn', 'yes:1')
  flip('cursorline', false)
  flip('laststatus', 0)
  flip('cmdheight', 0)

  if enabled then
    vim.diagnostic.disable()
  else
    vim.diagnostic.enable()
  end

  vim.cmd.Gitsigns('toggle_signs')
  vim.cmd.ScrollbarToggle()
end)
