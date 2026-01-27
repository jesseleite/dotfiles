--------------------------------------------------------------------------------
-- Telescope: Highly extendable fuzzy finders
--------------------------------------------------------------------------------

local t -- Telescope builtin pickers
local e -- Telescope extensions
local c -- Custom pickers

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'danielfalk/smart-open.nvim', branch = "0.2.x", dependencies = { "kkharji/sqlite.lua" }, dev = true },
  },
  cmd = {
    'Telescope',
  },
  keys = {
    { '<Leader>f', function () c.smart_open() end, desc = 'Telescope Smart Open' },
    { '<Leader>F', function () t.find_files() end, desc = 'Telescope All Files' },
    { '<Leader>h', function () print('JUST USE `<leader>f`, HOSER!') end, desc = 'Telescope Files' }, -- Retrain muscle memory
    { '<Leader>H', function () t.oldfiles() end, desc = 'Telescope All History' },
    { '<Leader>b', function () t.buffers() end, desc = 'Telescope Buffers' },
    { '<Leader>m', function () t.git_status() end, desc = 'Telescope Git Status' },
    { '<Leader>s', function () t.lsp_document_symbols() end, desc = 'Telescope LSP Symbols' },
    { '<Leader>S', function () c.lsp_document_methods() end, desc = 'Telescope LSP Methods' },
    { '<Leader>l', function () t.current_buffer_fuzzy_find() end, desc = 'Telescope Current Buffer Lines' },
    { '<Leader>C', function () t.commands() end, desc = 'Telescope Commands' },
    { '<Leader>:', function () t.command_history() end, desc = 'Telescope Command History' },
    { '<Leader>R', function () t.pickers() end, desc = 'Telescope Resume' },
    { '<Leader>?', function () t.help_tags() end, desc = 'Telescope Help Search' },
    { '<Leader><Leader>f', function () t.filetypes() end, desc = 'Telescope Filetypes' },
    { '<Leader><Leader>m', function () e.macroni.saved_macros() end, desc = 'Telescope Saved Macros', mode = { 'n', 'v' } },
    { '<Leader><Leader>v', function () c.vendor_files() end, desc = 'Telescope Vendor Files' },
    { '<Leader><Leader>t', function () t.builtin() end, desc = 'Telescope Builtin Pickers' },
    { '<Leader>/', function () e.live_grep_args.live_grep_args() end, desc = 'Telescope Live Grep Args' },
    { '<Leader>/', function () require('telescope-live-grep-args.shortcuts').grep_visual_selection() end, mode = 'x', desc = 'Telescope Live Grep Selection' },
    { '<Leader>*', function () require('telescope-live-grep-args.shortcuts').grep_word_under_cursor() end, desc = 'Telescope Live Grep Word' },
  },
  config = function ()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local custom_actions = require('jl.telescope.actions')
    local custom_layouts = require('jl.telescope.layouts')

    require('telescope.pickers.layout_strategies').helix = custom_layouts.helix

    telescope.setup {
      defaults = {
        prompt_prefix = '  ',
        sorting_strategy = "ascending",
        layout_strategy = 'helix',
        layout_config = {
          prompt_position = "top",
        },
        get_status_text = require('jl.telescope.layouts').get_status_text,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ['<Esc>'] = actions.close,
            ['<C-a>'] = actions.toggle_all,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-f>'] = custom_actions.show_all_files,
            ['<CR>'] = custom_actions.select_one_or_multi,
          },
        },
        file_ignore_patterns = {
          '.DS_Store',
          '.git/',
          'node_modules/',
          'git/submodules/',
          'resources/dist/',
          'storage/framework/',
          '_build/',
          '.elixir_ls/',
          '.expert/',
          '.hex$',
        },
        cache_picker = {
          num_pickers = -1,
        },
      },
      pickers = {
        find_files = {
          prompt_title = 'All Files',
          no_ignore = true,
          hidden = true,
        },
        current_buffer_fuzzy_find = {
          prompt_title = 'Current Buffer Lines',
        },
        oldfiles = {
          prompt_title = 'All History',
        },
        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-x>"] = actions.delete_buffer,
            }
          }
        },
      },
      extensions = {
        -- smart_open = {
        --   prompt_title = 'Smart Open',
        --   -- For some reason, not all extension/picker options work here, but they generally all work when passed into the keymap'd func
        --   -- See: https://github.com/danielfalk/smart-open.nvim/issues/49#issuecomment-3730770627
        -- },
        live_grep_args = {
          prompt_title = 'Live Ripgrep',
          mappings = {
            i = {
              ["''"] = require('telescope-live-grep-args.actions').quote_prompt(),
              ["-F"] = require('jl.telescope.actions').quote_prompt({ prefix = "-F -- " }),
            }
          }
        },
      },
    }

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('smart_open')
    telescope.load_extension('macroni')

    -- Shorthand helpers for mappings in `keys` funcs
    t = require('telescope.builtin')
    e = require('telescope').extensions
    c = require('jl.telescope.pickers')
  end
}
