--------------------------------------------------------------------------------
-- My Custom Telescope Sorters
--------------------------------------------------------------------------------

local sorters = require('telescope.sorters')
local fzf = require('fzf_lib')

local case_enum = {
  smart_case = 0,
  ignore_case = 1,
  respect_case = 2,
}

local M = {}

--- FZF-native sorter that preserves original entry order (by `entry.index`).
--- Gives you full fzf extended syntax (OR `|`, exact `'`, prefix `^`, suffix `$`, inverse `!`)
--- while scoring by index position instead of match quality.
M.fzf_index_sorter = function(opts)
  opts = opts or {}

  local case_mode = case_enum[opts.case_mode or 'smart_case']
  local fuzzy_mode = opts.fuzzy == nil and true or opts.fuzzy

  local post_or = false
  local post_inv = false
  local post_escape = false

  local get_struct = function(self, prompt)
    local struct = self.state.prompt_cache[prompt]
    if not struct then
      struct = fzf.parse_pattern(prompt, case_mode, fuzzy_mode)
      self.state.prompt_cache[prompt] = struct
    end
    return struct
  end

  return sorters.Sorter:new({
    init = function(self)
      self.state.slab = fzf.allocate_slab()
      self.state.prompt_cache = {}
    end,

    destroy = function(self)
      for _, v in pairs(self.state.prompt_cache) do
        fzf.free_pattern(v)
      end
      self.state.prompt_cache = {}
      if self.state.slab ~= nil then
        fzf.free_slab(self.state.slab)
        self.state.slab = nil
      end
    end,

    start = function(self, prompt)
      local last = prompt:sub(-1, -1)

      if last == '|' then
        self._discard_state.filtered = {}
        post_or = true
      elseif last == ' ' and post_or then
        self._discard_state.filtered = {}
      elseif post_or then
        self._discard_state.filtered = {}
        post_or = false
      else
        post_or = false
      end

      if last == '\\' and not post_escape then
        self._discard_state.filtered = {}
        post_escape = true
      else
        self._discard_state.filtered = {}
        post_escape = false
      end

      if last == '!' and not post_inv then
        post_inv = true
        self._discard_state.filtered = {}
      elseif post_inv then
        self._discard_state.filtered = {}
      elseif post_inv and ' ' then
        post_inv = false
      end
    end,

    discard = true,

    scoring_function = function(self, prompt, line, entry)
      if #prompt == 0 then
        return 1
      end

      local score = fzf.get_score(line, get_struct(self, prompt), self.state.slab)

      if score == 0 then
        return -1
      end

      return entry.index
    end,

    highlighter = function(self, prompt, display)
      return fzf.get_pos(display, get_struct(self, prompt), self.state.slab)
    end,
  })
end

return M
