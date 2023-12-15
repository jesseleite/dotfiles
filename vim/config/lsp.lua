--------------------------------------------------------------------------------
-- LSP Config
--------------------------------------------------------------------------------

local lspconfig = require('lspconfig')

-- Lua
-- Does lua_ls use same options as sumneko?
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim', 'Ray', 'hs', 'spoon'},
        disable = {"lowercase-global"},
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

-- Vue
lspconfig.vuels.setup { }

-- Yaml
lspconfig.yamlls.setup { }

-- Json
lspconfig.jsonls.setup { }

-- Html
lspconfig.html.setup {
  filetypes = {'html', 'blade', 'antlers'}
}

-- Antlers
lspconfig.antlersls.setup { }

-- Tailwind
lspconfig.tailwindcss.setup { }
