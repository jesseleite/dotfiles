return {
  'SirVer/ultisnips', -- GOTEEEEEEM! ...TODO: I need to switch over to LuaSnip furreal though
  init = function ()
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
  end,
}
