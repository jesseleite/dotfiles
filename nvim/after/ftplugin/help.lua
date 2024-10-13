-- Fullscreen the help window
vim.cmd.wincmd('o')

-- Enter to go into help doc link
vim.keymap.set('n', '<CR>', '<C-]>', { buffer = true })

-- Esc to jump back to last help doc
vim.keymap.set('n', '<Esc>', '<C-t>', { buffer = true })
