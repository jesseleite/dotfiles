--------------------------------------------------------------------------------
-- LSP Config
--------------------------------------------------------------------------------

local lspconfig = require('lspconfig')

-- Lua
lspconfig.sumneko_lua.setup {
  cmd = {'lua-langserver', '-E', '/usr/local/Cellar/lua-language-server/1.19.0/main.lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim', 'Ray'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

-- Vimscript / VimL
lspconfig.vimls.setup { }

-- PHP
lspconfig.intelephense.setup { }
-- lspconfig.phpactor.setup {
--   cmd = {vim.fn.stdpath('config') .. '/plugged/phpactor/bin/phpactor', 'language-server'},
-- }

-- Vue
lspconfig.vuels.setup { }

-- Yaml
lspconfig.yamlls.setup { }

-- Json
lspconfig.jsonls.setup { }

-- Html
lspconfig.html.setup({
  filetypes = {'html', 'blade', 'antlers'}
})
