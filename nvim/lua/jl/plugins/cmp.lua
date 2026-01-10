--------------------------------------------------------------------------------
-- Cmp: A completion engine plugin
--------------------------------------------------------------------------------

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function ()
    local cmp = require('cmp')

    cmp.setup {
      window = require('noirbuddy.plugins.cmp').window,
      preselect = cmp.PreselectMode.None,
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<C-e>'] = cmp.mapping.complete(),
      },
      sources = cmp.config.sources({
        { name = 'lazydev', group_index = 0 },
        { name = 'luasnip', group_index = 1 },
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'path', group_index = 1 },
        { name = 'buffer', group_index = 2 },
      }),
    }

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path', group_index = 1 },
        { name = 'cmdline', group_index = 2 },
      }),
      -- matching = {
      --   disallow_symbol_nonprefix_matching = false, -- What does this even do?
      -- },
    })

    -- Note: See nvim/lua/jl/lspconfig/init.lua for
    -- nvim-cmp + LSP capabilities integration!
  end,
}
