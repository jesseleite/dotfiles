--------------------------------------------------------------------------------
-- Telescope Config
--------------------------------------------------------------------------------

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    prompt_prefix = '  ',
    sorting_strategy = "ascending",
    prompt_position = "top",
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    file_ignore_patterns = { 'node_modules' },
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
  },
}

telescope.load_extension('fzf')
telescope.load_extension('sourcery')
telescope.load_extension('ultisnips')


--------------------------------------------------------------------------------
-- Custom Finders
--------------------------------------------------------------------------------

local builtin = require('telescope.builtin')

builtin.dotfiles = function ()
  builtin.find_files({
    prompt_title = 'Dotfiles',
    cwd = "$HOME/.dotfiles",
  })
end

builtin.project_history = function ()
  builtin.oldfiles({
    prompt_title = 'Project History',
    cwd_only = true,
  })
end
