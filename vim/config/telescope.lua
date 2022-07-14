--------------------------------------------------------------------------------
-- Telescope Config
--------------------------------------------------------------------------------

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
        ["<Esc>"] = actions.close,
        ["<C-a>"] = actions.toggle_all,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = { 'node_modules' },
    -- vimgrep_arguments = {'ag', '--nogroup', '--column'},
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
}

telescope.load_extension('fzf')
telescope.load_extension('sourcery')
telescope.load_extension('ultisnips')
telescope.load_extension('live_grep_args')


--------------------------------------------------------------------------------
-- Custom Finders
--------------------------------------------------------------------------------

local builtin = require('telescope.builtin')

builtin.dotfiles = function ()
  builtin.find_files({
    prompt_title = 'Dotfiles',
    cwd = "$HOME/.dotfiles",
    file_ignore_patterns = {
      '^.git/',
      '^git/submodules/',
    },
  })
end

builtin.project_history = function ()
  builtin.oldfiles({
    prompt_title = 'Project History',
    cwd_only = true,
  })
end


--------------------------------------------------------------------------------
-- Dropdown With Preview
--------------------------------------------------------------------------------

local resolve = require("telescope.config.resolve")

local function get_initial_window_options(picker)
  local popup_border = resolve.win_option(picker.window.border)
  local popup_borderchars = resolve.win_option(picker.window.borderchars)

  local preview = {
    title = picker.preview_title,
    border = popup_border.preview,
    borderchars = popup_borderchars.preview,
    enter = false,
    highlight = false
  }

  local results = {
    title = picker.results_title,
    border = popup_border.results,
    borderchars = popup_borderchars.results,
    enter = false,
  }

  local prompt = {
    title = picker.prompt_title,
    border = popup_border.prompt,
    borderchars = popup_borderchars.prompt,
    enter = true
  }

  return {
    preview = preview,
    results = results,
    prompt = prompt,
  }
end

require('telescope.pickers.layout_strategies').telescopic_jersey = function(self, max_columns, max_lines)
  local initial_options = get_initial_window_options(self)
  local preview = initial_options.preview
  local results = initial_options.results
  local prompt = initial_options.prompt

  local width_padding = resolve.resolve_width(function(_, cols)
    if cols < self.preview_cutoff then
      return 2
    elseif cols < 150 then
      return 5
    else
      return 10
    end
  end)(self, max_columns, max_lines)
  local picker_width = max_columns - 2 * width_padding

  local height_padding = resolve.resolve_height(function(_, _, lines)
    if lines < 40 then
      return 4
    else
      return math.floor(0.1 * lines)
    end
  end)(self, max_columns, max_lines)
  local picker_height = max_lines - 2 * height_padding

  if self.previewer then
    preview.width = resolve.resolve_width(function(_, cols)
      if not self.previewer or cols < self.preview_cutoff then
        return 0
      elseif cols < 150 then
        return math.floor(cols * 0.4)
      elseif cols < 200 then
        return 70
      else
        return 100
      end
    end)(self, picker_width, max_lines)
  else
    preview.width = 0
  end

  prompt.width = picker_width - preview.width
  results.width = picker_width - preview.width

  prompt.height = 1
  results.height = picker_height - prompt.height - 1

  if self.previewer then
    preview.height = picker_height
  else
    preview.height = 0
  end

  prompt.col = width_padding
  results.col = width_padding
  preview.col = results.col + results.width + 2

  preview.line = height_padding
  preview.borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'}

  local top_borderchars = {"─", "│", "─", "│", "╭", "╮", "┤", "├"}
  local bottom_borderchars = {"─", "│", "─", "│", "├", "┤", "╯", "╰"}

  if self.window.prompt_position == "top" then
    prompt.line = height_padding
    results.line = prompt.line + prompt.height + 1
    prompt.borderchars = top_borderchars
    results.borderchars = bottom_borderchars
    results.title = false
  elseif self.window.prompt_position == "bottom" then
    results.line = height_padding
    prompt.line = results.line + results.height + 1
    results.borderchars = top_borderchars
    prompt.borderchars = bottom_borderchars
    results.title = prompt.title
    prompt.title = false
  else
    error("Unknown prompt_position: " .. self.window.prompt_position)
  end

  return {
    preview = self.previewer and preview.width > 0 and preview,
    results = results,
    prompt = prompt,
  }
end
