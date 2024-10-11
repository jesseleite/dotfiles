vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

local hooks = require('jl.mini.splitjoin.hooks')

vim.b.minisplitjoin_config = {
  split = { hooks_post = { hooks.add_comma_curly } },
  join  = { hooks_post = { hooks.del_comma_curly, hooks.pad_curly } },
}


--------------------------------------------------------------------------------
-- Stuff for Neovim plugin dev that can probably get smarter...
--------------------------------------------------------------------------------

local detect_plugin_package = function ()
  require('macroni').run("m'magg/^return<Space>{<CR>f/<M-o>\"qy<Esc>")
  local package = vim.fn.getreg('q')
  vim.cmd("'a")
  return package
end

local plugin_goto_github = function ()
  vim.ui.open('https://github.com/'..detect_plugin_package())
end

local reload_current_plugin = function ()
  local plugin = vim.fn.substitute(detect_plugin_package(), '.*/', '', '')
  vim.cmd.Lazy('reload '..plugin)
end

local save_and_execute_current_file = function ()
  vim.cmd.write()
  vim.cmd.source('%')

  -- TODO: Not sure why, but it seems you need to save the file and wait a few seconds before reloading
  -- plugin, or it doesn't take changes. Maybe something related to plugin file caching in lazy.nvim?
  if vim.fn.expand('%:h:t') == 'plugins' and vim.fn.expand('%:h:h:t') == 'jl' then
    reload_current_plugin()
  end
end

vim.keymap.set('n', '<Leader>gg', plugin_goto_github, { silent = true, desc = 'Go To Plugin Github' })
vim.keymap.set('n', '<Leader>x', save_and_execute_current_file, { desc = 'Execute Current File' })
vim.keymap.set('n', '<Leader><Leader>x', ':.lua<CR>', { desc = 'Execute Current Line' })
