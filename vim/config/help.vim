" ------------------------------------------------------------------------------
" # Register Help Local Mappings
" ------------------------------------------------------------------------------

augroup help_local_mappings
  autocmd!
  autocmd BufWinEnter * if &l:buftype ==# 'help' | call HelpLocalMappings() | endif
augroup END


" ------------------------------------------------------------------------------
" # Load Fullscreen Help Buffers
" ------------------------------------------------------------------------------

augroup fullscreen_help_buffer
  autocmd!
  autocmd BufWinEnter * if &l:buftype ==# 'help' | wincmd o | endif
augroup END
