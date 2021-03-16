--------------------------------------------------------------------------------
-- Telescope Config
--------------------------------------------------------------------------------

local telescope = require('telescope')
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
    file_ignore_patterns = { 'node_modules' },
  }
}

telescope.load_extension('fzy_native')
telescope.load_extension('sourcery')
telescope.load_extension('ultisnips')


--------------------------------------------------------------------------------
-- Custom Finders
--------------------------------------------------------------------------------

-- Implemented directly with `Telescope find_files` mapping and `cwd` option...
-- local find_dotfiles = function()
--     require("telescope.builtin").find_files({
--         prompt_title = 'My Dotfiles',
--         cwd = "$HOME/.dotfiles",
--     })
-- end
