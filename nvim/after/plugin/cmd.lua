--------------------------------------------------------------------------------
-- Command Mode Tweaks
--------------------------------------------------------------------------------

local cmdmode_group = vim.api.nvim_create_augroup('cmdmode', { clear = true })

vim.api.nvim_create_autocmd('CmdLineEnter', {
  group = cmdmode_group,
  callback = function ()
    vim.wo.relativenumber = false
    vim.cmd.redraw()
  end
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
  group = cmdmode_group,
  callback = function ()
    vim.wo.relativenumber = true
  end
})


--------------------------------------------------------------------------------
-- Command Window Tweaks
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = vim.api.nvim_create_augroup('cmdwin_local', { clear = true }),
  callback = function ()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})
