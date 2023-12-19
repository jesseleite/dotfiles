return {
  intelephense = true,
  html = {
    filetypes = { 'html', 'blade', 'antlers' },
  },
  antlersls = true,
  tailwindcss = true,
  volar = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  jsonls = true,
  yamlls = true,
  lua_ls = {
    settings = {
      Lua = {
        -- runtime = {
        --   version = 'LuaJIT',
        --   path = vim.split(package.path, ';'),
        -- },
        diagnostics = {
          globals = {'vim', 'Ray', 'hs', 'spoon'},
          disable = {"lowercase-global"},
        },
        -- workspace = {
        --   library = {
        --     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        --     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        --   },
        -- },
      },
    },
  },
  vimls = true,
}
