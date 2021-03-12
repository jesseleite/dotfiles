local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
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

require('telescope').load_extension('sourcery')
