return {

  -- Function
  s('func', fmt('function ({})\n\t{}\nend', { i(1), i(0) })),

  -- Inline function
  s('fn', fmt('function ({}) {} end', { i(1), i(2) })),

  -- Pretty 80 character header block
  s('header', fmt('{}\n-- {}\n{}', {
    t('--------------------------------------------------------------------------------'),
    i(0),
    t('--------------------------------------------------------------------------------'),
  })),

  -- Neovim keymap
  s('map', fmt("vim.keymap.set('{}', '{}', {})", { i(1, 'n'), i(2), i(0) })),

}
