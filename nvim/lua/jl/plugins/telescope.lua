--------------------------------------------------------------------------------
-- Telescope: Highly extendable fuzzy finders
--------------------------------------------------------------------------------

local builtin = lazy_require('telescope.builtin')
local custom = lazy_require('jl.telescope.pickers')

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  cmd = {
    'Telescope',
  },
  keys = {
    { '<Leader>f', builtin.git_files, desc = 'Telescope Git Files' },
    { '<Leader>F', builtin.find_files, desc = 'Telesscope All Files' },
    { '<Leader>b', custom.buffers, desc = 'Telescope Buffers' },
    { '<Leader>m', builtin.git_status, desc = 'Telescope Git Status' },
    { '<Leader>h', custom.project_history, desc = 'Telescope Project History' },
    { '<Leader>H', builtin.oldfiles, desc = 'Telescope History' },
    { '<Leader>s', custom.lsp_document_methods, desc = 'Telescope LSP Methods' },
    { '<Leader>S', builtin.lsp_document_symbols, desc = 'Telescope LSP Symbols' },
    { '<Leader>l', builtin.current_buffer_fuzzy_find, desc = 'Telescope Current Buffer Lines' },
    { '<Leader>L', custom.laravel_vendor_files, desc = 'Telescope Laravel Vendor Files' },
    { '<Leader>C', builtin.commands, desc = 'Telescope Commands' },
    { '<Leader>:', builtin.command_history, desc = 'Telescope Command History' },
    { '<Leader>R', builtin.pickers, desc = 'Telescope Resume' },
    { '<Leader><Leader>d', custom.dotfiles, desc = 'Telescope Dotfiles' },
    { '<Leader><Leader>v', custom.nvim_dotfiles, desc = 'Telescope Nvim Dotfiles' },
    { '<Leader><Leader>h', builtin.help_tags, desc = 'Telescope Help Search' },
    { '<Leader><Leader>f', builtin.filetypes, desc = 'Telescope Filetypes' },
    { '<Leader><Leader>t', builtin.builtin, desc = 'Telescope Builtin Pickers' },
    { '<Leader>/', function () require('telescope').extensions.live_grep_args.live_grep_args() end, desc = 'Telescope Live Grep Args' }
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
        mappings = {
          i = {
            ['<Esc>'] = actions.close,
            ['<C-a>'] = actions.toggle_all,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<CR>'] = custom_actions.select_one_or_multi,
          },
        },
        file_ignore_patterns = {
          'node_modules',
          '.DS_Store',
          '.git/',
          'resources/dist',
          'storage/framework',
        },
        cache_picker = {
          num_pickers = -1,
        },
      },
      pickers = {
        git_files = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["@"] = custom_actions.select_file_and_accept_method,
            }
          }
        },
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
          mappings = {
            i = {
              ["<C-x>"] = "delete_buffer",
            }
          }
        },
      },
      extensions = {
        live_grep_args = {
          prompt_title = 'Live Ripgrep',
          mappings = {
            i = {
              ["<C-k>"] = require('telescope-live-grep-args.actions').quote_prompt(),
            }
          }
        }
      },
    }

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('ui-select')
  end
}
