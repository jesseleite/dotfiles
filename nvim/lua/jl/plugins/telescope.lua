--------------------------------------------------------------------------------
-- Telescope: Highly extendable fuzzy finders
--------------------------------------------------------------------------------

local builtin = require_on_exported_call('telescope.builtin')
local custom = require_on_exported_call('jl.telescope.pickers')

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
    { '<Leader>E', builtin.file_browser, desc = 'Telescope File Browser' },
    { '<Leader>b', custom.buffers, desc = 'Telescope Buffers' },
    { '<Leader>m', builtin.git_status, desc = 'Telescope Git Status' },
    { '<Leader>h', custom.project_history, desc = 'Telescope Project History' },
    { '<Leader>H', builtin.oldfiles, desc = 'Telescope History' },
    { '<Leader>s', custom.lsp_document_methods, desc = 'Telescope LSP Methods' },
    { '<Leader>S', builtin.lsp_document_symbols, desc = 'Telescope LSP Symbols' },
    { '<Leader>l', builtin.current_buffer_fuzzy_find, desc = 'Telescope Current Buffer Lines' },
    { '<Leader>L', builtin.pickers, desc = 'Telescope Resume' },
    { '<Leader>C', builtin.commands, desc = 'Telescope Commands' },
    { '<Leader>:', builtin.command_history, desc = 'Telescope Command History' },
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

    telescope.setup {
      defaults = {
        prompt_prefix = '  ',
        sorting_strategy = "ascending",
        -- layout_strategy = "telescopic_jersey",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ['<Esc>'] = actions.close,
            ['<C-a>'] = actions.toggle_all,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        file_ignore_patterns = { 'node_modules', '.DS_Store', 'resources/dist' },
      },
      pickers = {
        find_files = {
          prompt_title = 'All Files',
          find_command = {'rg', '--files', '--no-ignore', '--hidden'},
        },
        current_buffer_fuzzy_find = {
          prompt_title = 'Current Buffer Lines',
        },
        oldfiles = {
          prompt_title = 'History',
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
