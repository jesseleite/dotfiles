--------------------------------------------------------------------------------
-- Treesitter: Parser installer, highlighting, indent, textobjects, context
--------------------------------------------------------------------------------
-- nvim-treesitter `main` is a rewrite. Highlighting/folds are Neovim builtins;
-- this plugin installs parsers + queries. `master` is frozen and broken on 0.12.

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'nvim-treesitter/nvim-treesitter-context',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  lazy = false,
  keys = {
    { '<Leader><Leader>c', function () require('treesitter-context').toggle() end, desc = 'Toggle Treesitter Context' },
  },
  config = function ()
    require('nvim-treesitter').install(vim.tbl_filter(function (lang)
      return not ({ phpdoc = true, rnoweb = true })[lang]
    end, require('nvim-treesitter').get_available()))

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('enable_treesitter', { clear = true }),
      callback = function (ev)
        if not pcall(vim.treesitter.start, ev.buf) then
          return
        end
        local lang = vim.treesitter.language.get_lang(ev.match)
        local has_indent_query = lang and vim.treesitter.query.get(lang, 'indents') ~= nil
        if has_indent_query then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
        selection_modes = {
          ['@class.inner'] = 'V',
          ['@class.outer'] = 'V',
          ['@function.inner'] = 'V',
          ['@function.outer'] = 'V',
          ['@loop.inner'] = 'V',
          ['@loop.outer'] = 'V',
          ['@statement.outer'] = 'V',
        },
      },
    })

    for lhs, query in pairs({
      ['iC'] = '@class.inner',
      ['aC'] = '@class.outer',
      ['if'] = '@function.inner',
      ['af'] = '@function.outer',
      ['ib'] = '@block.inner',
      ['ab'] = '@block.outer',
      ['il'] = '@loop.inner',
      ['al'] = '@loop.outer',
      ['is'] = '@statement.outer', -- inner statement doesn't exist
      ['as'] = '@statement.outer',
      ['ia'] = '@parameter.inner', -- `a` for arg, because `p` is paragraph object
      ['aa'] = '@parameter.outer',
      ['ih'] = '@attribute.inner', -- `h` for html, because `a` is attribute above
      ['ah'] = '@attribute.outer',
    }) do
      vim.keymap.set({ 'x', 'o' }, lhs, function ()
        require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
      end)
    end

    require('treesitter-context').setup({
      enable = false,
      mode = 'topline',
      multiwindow = true,
      multiline_threshold = 1,
      separator = '─',
    })

    require('ts_context_commentstring').setup({})
  end,
}
