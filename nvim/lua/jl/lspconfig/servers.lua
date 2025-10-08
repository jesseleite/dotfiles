--------------------------------------------------------------------------------
-- Configured Lsp Servers
--------------------------------------------------------------------------------

return {
  -- expert = true,
  elixirls = {
    cmd = { "elixir-ls" },
  },
  html = {
    filetypes = { 'html', 'blade', 'antlers' },
  },
  emmet_language_server = {
    filetypes = { 'html', 'blade', 'antlers', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  tailwindcss = {
    filetypes = { 'html', 'blade', 'antlers', 'css' },
  },
  -- antlersls = true,
  ts_ls = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  vue_ls = true,
  gopls = true,
  jsonls = true,
  yamlls = true,
  intelephense = {
    settings = {
      intelephense = {
        telemetry = {
          enabled = false,
        },
      },
    },
  },
  -- phpactor = true,
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'hs', 'spoon', -- hammerspoon
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
