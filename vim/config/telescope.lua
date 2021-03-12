--------------------------------------------------------------------------------
-- Telescope Config
--------------------------------------------------------------------------------

local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    prompt_prefix = '  ',
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
  }
}

telescope.load_extension('fzy_native')
telescope.load_extension('sourcery')


--------------------------------------------------------------------------------
-- Custom Finders
--------------------------------------------------------------------------------

-- local find_dotfiles = function() 
--     require("telescope.builtin").find_files({
--         prompt_title = 'My Dotfiles',
--         cwd = "$HOME/.dotfiles",
--     })
-- end
