--------------------------------------------------------------------------------
-- Configured Lsp Servers
--------------------------------------------------------------------------------

return {
  intelephense = {
    settings = {
      intelephense = {
        telemetry = {
          enabled = false,
        },
        -- files = {
        --   exclude = {
        --     'vendor',
        --   },
        -- },
        -- diagnostics = {
        --   unusedSymbols = false,
        -- },
      },
    },
  },
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
  -- TODO: John help!
  antlersls = {
    showGeneralSnippetCompletions = false,
    settings = {
      showGeneralSnippetCompletions = false,
      antlersls = {
        showGeneralSnippetCompletions = false,
      },
      antlers = {
        showGeneralSnippetCompletions = false,
      },
      html = {
        showGeneralSnippetCompletions = false,
      },
    },
  },
  vtsls = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  -- TODO: Why doesn't vue_ls work? Mason installs vue_ls, but we have to use volar here?
  volar = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  jsonls = true,
  yamlls = true,
  gopls = true,
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
