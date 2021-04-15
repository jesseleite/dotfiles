--------------------------------------------------------------------------------
-- Telescope Config
--------------------------------------------------------------------------------

local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    prompt_prefix = '  ',
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    file_ignore_patterns = { 'node_modules' },
  }
}

telescope.load_extension('fzf')
telescope.load_extension('sourcery')
telescope.load_extension('ultisnips')


--------------------------------------------------------------------------------
-- Custom Finders
--------------------------------------------------------------------------------

builtin.all_files = function ()
  builtin.find_files({
    prompt_title = 'All Files',
    find_command = {'rg', '--files', '--no-ignore', '--hidden'},
  })
end

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

builtin.history = function()
  builtin.oldfiles({
    prompt_title = 'History',
  })
end

builtin.current_buffer_lines = function ()
  builtin.current_buffer_fuzzy_find({
    prompt_title = 'Current Buffer Lines',
    sorting_strategy = 'ascending',
  })
end
