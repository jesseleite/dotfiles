--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------
-- This is where I put stuff that I'm either testing or embarassed about.
-- No shame; Just aliens, UFOs, cows, and crazy vimscript shenanigans.

-- Toggle scrollbind in all windows
local function toggle_scrollbind()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local toggle_value = not vim.wo[wins[1]].scrollbind

  for _, win in ipairs(wins) do
    vim.wo[win].scrollbind = toggle_value
  end

  vim.notify('Scrollbind ' .. (toggle_value and 'enabled' or 'disabled'))
end

vim.keymap.set('n', '<Leader><Leader>j', toggle_scrollbind, { desc = 'Toggle scrollbind in all windows' })

-- Helix mode concept
-- vim.keymap.set({'n', 'x'}, 'w', '<Esc>vw')

-- function! LaravelConvertToRealTimeFacade()
--   let classUnderCursor = expand("<cword>")
--   call search('use .*\\'.classUnderCursor, 'sb')
--   s/use /use Facades\\/
-- endfunction
-- autocmd FileType php nnoremap <buffer> <Leader>pr :call LaravelConvertToRealTimeFacade()<CR>

-- function! ClearRegisters()
--   let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
--   let i=0
--   while (i<strlen(regs))
--       exec 'let @'.regs[i].'=""'
--       let i=i+1
--   endwhile
-- endfunction

-- nnoremap <silent> <Leader><Leader>p :args *<CR>
-- nnoremap <silent> <Leader><Leader>j :bnext<CR>
-- nnoremap <silent> <Leader><Leader>k :bprev<CR>

-- " Close current antlers tag pair...
-- function! CloseAntlersPair()
--   ... redo w/ macroni
-- endfunction

-- Will I miss this?
-- Peek into registers
-- Plug 'junegunn/vim-peekaboo'
-- let g:peekaboo_window = 'vertical botright 60new'
