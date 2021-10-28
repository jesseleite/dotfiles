" ------------------------------------------------------------------------------
" # Scrollbar Settings
" ------------------------------------------------------------------------------

let g:scrollbar_right_offset = 0

let g:scrollbar_shape = {
  \ 'head': '▐',
  \ 'body': '▐',
  \ 'tail': '▐',
  \ }

let g:scrollbar_highlight = {
  \ 'head': 'Ignore',
  \ 'body': 'Ignore',
  \ 'tail': 'Ignore',
  \ }

augroup scrollbar_init
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost * silent! lua require('scrollbar').clear()
  autocmd CursorHold,CursorHoldI * silent! lua require('scrollbar').clear()
augroup end
