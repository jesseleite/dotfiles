return {
  'mattn/emmet-vim',
  keys = {
    { '<C-e>', '<plug>(emmet-expand-abbr)', mode = 'i' },
    { ']e', '<plug>(emmet-move-next)' },
    { '[e', '<plug>(emmet-move-prev)' },
  },
  init = function ()
    -- Remapping the emmet leader key, but only because we can't yet disable it
    -- See: https://github.com/mattn/emmet-vim/issues/528
    vim.g.user_emmet_leader_key = '<C-Z>'
  end,
}
