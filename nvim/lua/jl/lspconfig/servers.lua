--------------------------------------------------------------------------------
-- Configured Lsp Servers
--------------------------------------------------------------------------------

return {
  intelephense = true,
  -- phpactor = true,
  html = {
    filetypes = { 'html', 'blade', 'antlers' },
  },
  emmet_language_server = {
    filetypes = { 'html', 'blade', 'antlers' },
  },
  tailwindcss = {
    filetypes = { 'html', 'blade', 'antlers', 'css' },
  },
  antlersls = true,
  volar = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  jsonls = true,
  yamlls = true,
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            -- 'hs', 'spoon', -- hammerspoon
            -- 'vim', 'Ray', -- generic vim
            's', 'sn', 'fmt', 'i', 'c', 't', 'f', 'd', 'extras', -- luasnip
          },
          disable = {
            'missing-fields',
            -- 'lowercase-global', -- do I still want this?
          },
        },
        workspace = {
          library = {
            -- ["~/.dotfiles/hammerspoon/spoons/EmmyLua.spoon/annotations"] = true,
          },
        },
      },
    },
  },
  vimls = true,
}
