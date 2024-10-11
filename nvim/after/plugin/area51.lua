--------------------------------------------------------------------------------
-- Experimental Stuff
--------------------------------------------------------------------------------
-- This is where I put stuff that I'm either testing or embarassed about.
-- No shame; Just aliens, UFOs, cows, and crazy vimscript shenanigans.

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

-- vim.opt.ttimeoutlen = 5 -- Vim8 defaulted to 100, but I'm trying out 5ms to avoid ESC lag
-- vim.opt.ch = 0 -- see :help cmdheight, but this is experimental and still has some issues

-- Do I really need this?
-- " Additional text objects, and better seeking
-- Plug 'wellle/targets.vim'
-- let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

-- Will I miss this?
-- Peek into registers
-- Plug 'junegunn/vim-peekaboo'
-- let g:peekaboo_window = 'vertical botright 60new'


--------------------------------------------------------------------------------
-- Adrian made me do this...
-- Roll with it for a while to see how well it works?
-- Requires tpope/vim-surround
--------------------------------------------------------------------------------

local toggle_surrounding_quote_style = function ()
  local current_line = vim.fn.line('.')
  local next_single_quote = vim.fn.searchpos("'", 'cn')
  local next_double_quote = vim.fn.searchpos('"', 'cn')

  if next_single_quote[1] ~= current_line then
    next_single_quote = false
  end

  if next_double_quote[1] ~= current_line then
    next_double_quote = false
  end

  if next_single_quote == false and next_double_quote == false then
    print('Could not find quotes on current line!')
  elseif next_single_quote == false and next_double_quote ~= false then
    vim.cmd.normal([[macs"'`a]])
  elseif next_single_quote ~= false and next_double_quote == false then
    vim.cmd.normal([[macs'"`a]])
  elseif next_single_quote[2] > next_double_quote[2] then
    vim.cmd.normal([[macs"'`a]])
  else
    vim.cmd.normal([[macs'"`a]])
  end
end

vim.keymap.set('n', "<Leader>'", toggle_surrounding_quote_style)
