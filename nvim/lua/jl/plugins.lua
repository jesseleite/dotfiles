--------------------------------------------------------------------------------
-- Plugins (the ones which don't require any extra config)
--------------------------------------------------------------------------------

-- Short helper for plugins that require lua .setup() call 🤏
local s = function (plugin)
  return { plugin, config = true }
end

-- If not a simple one-liner, maybe extract to plugins folder; Otherwise just throw in here 💥
return {
  'tpope/vim-commentary', -- Code commenting
  'tpope/vim-surround', -- Surround commands
  'tpope/vim-repeat', -- Better `.` repeat
  'PeterRincker/vim-searchlight', -- Improved search match highlighting
  'jesseleite/vim-noh', -- Auto-clear search highlighting
  'markonm/traces.vim', -- Improved substitute highlighting and previewing
  s('windwp/nvim-autopairs'), -- Auto-pair closing brackets, quotes, etc.
  s('nmac427/guess-indent.nvim'), -- Smart indentation width detection
  s('JoosepAlviste/nvim-ts-context-commentstring'), -- Commentstring detection for embedded languages
}
