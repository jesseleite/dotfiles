--------------------------------------------------------------------------------
-- Sneak motion and better f/t motions
--------------------------------------------------------------------------------

return {
  'justinmk/vim-sneak',
  keys = {
    { 'f', '<Plug>Sneak_f' },
    { 'F', '<Plug>Sneak_F' },
    { 't', '<Plug>Sneak_t' },
    { 'T', '<Plug>Sneak_T' },
  },
  init = function ()
    vim.g['sneak#use_ic_scs'] = 1
  end,
  config = function ()
    local Group = require('colorbuddy').Group
    local groups = require('colorbuddy').groups

    Group.link('Sneak', groups.IncSearch)
  end,
}
