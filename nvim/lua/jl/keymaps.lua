--------------------------------------------------------------------------------
-- General Keymaps (that aren't related other plugins or config modules)
--------------------------------------------------------------------------------

-- Map leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Write and quit like a monster
vim.keymap.set('n', '<Leader>w', ':w<CR>', { silent = true })
vim.keymap.set('n', '<Leader>q', ':q<CR>')

-- Exit insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Edit current command in normal mode using command line window
-- vim.keymap.set('c', 'jk', '<C-f>')
-- TODO: This messes with flash.nvim's label if `j` is pressed. Remap to `<C-something>` else?

-- Edit the alternate / previously edited file
vim.keymap.set('n', '<Leader>a', '<C-^>')

-- Vertical split
vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit, { silent = true })

-- Cycle through windows
vim.keymap.set('n', '<Tab>', '<C-w>w')
vim.keymap.set('n', '<S-Tab>', '<C-w>W')

-- Make window only window
vim.keymap.set('n', '<Leader>O', '<C-w>o')

-- Disable ctrl-f/b scrolling (ctrl-d/u all the way 🤘)
vim.keymap.set('n', '<C-f>', '<Nop>')
vim.keymap.set('n', '<C-b>', '<Nop>')

-- Break undo sequence on specific characters
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', '!', '!<C-g>u')
vim.keymap.set('i', '?', '?<C-g>u')

-- Quicker macro playback
vim.keymap.set('n', 'Q', '@qj')
vim.keymap.set('x', 'Q', ':norm @q<CR>')

-- Delete text on line
vim.keymap.set('n', '<Leader>d', 'ddO<Esc>')

-- Open line, but stay in normal mode
vim.keymap.set('n', '<Leader><CR>', 'o<Esc>')

-- Open line, with an extra blank line below that one
vim.keymap.set('n', '<Leader><Leader><CR>', 'o<C-o>O')

-- Move line(s) up and down
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==gi', { silent = true })
vim.keymap.set('v', '<C-j>', ':m \'>+1<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<C-k>', ':m \'<-2<CR>gv=gv', { silent = true })

-- Quickly append semicolon or comma
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Keep visual selection when indenting
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- Auto-indent whole file
vim.keymap.set('n', '<Leader>=', 'ggVG=')

-- Visual paste without losing what is in register
-- This first mapping doesn't work because vim-pasta hijacks it
-- Keep an eye on this... https://github.com/sickill/vim-pasta/pull/18
-- vnoremap p "0p
vim.keymap.set('v', '<leader>p', '"0p')

-- Clear search highlighting
vim.keymap.set('n', '<Leader>.', vim.cmd.nohlsearch, { silent = true })

-- Increment/decrement numbers holding shift-`+/-` keys instead of ctrl-`a/x`
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '_', '<C-x>')
vim.keymap.set('v', '+', '<C-a>gv')
vim.keymap.set('v', '_', '<C-x>gv')

-- Open in finder
vim.keymap.set('n', '<Leader><Leader>o', ':!open $PWD<CR><CR>', { silent = true })

-- Browse with herd open
vim.keymap.set('n', '<Leader><Leader>b', ':!herd open<CR><CR>', { silent = true })

-- Open in tower
vim.keymap.set('n', '<Leader><Leader>g', ':!gittower $PWD<CR><CR>', { silent = true })

-- Inspect treesitter captures / color groups under cursor
vim.keymap.set('n', '<Leader><Leader>c', vim.cmd.TSHighlightCapturesUnderCursor)
