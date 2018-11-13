" ------------------------------------------------------------------------------
" # Sane defaults
" ------------------------------------------------------------------------------

set hidden
set nobackup
set noswapfile
set autoread
set confirm
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set relativenumber
set noshowmode

" Set updatetime for CursorHold, gitgutter, etc.
set updatetime=1000

" Auto complete menu options
set completeopt=menu,menuone,noinsert,noselect

" Yeah, it's a package, but it comes with vim
packadd! matchit

" Check for external changes and reload buffer
augroup check_for_external_changes
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
augroup END

" This one causes deoplete flicker?
" set lazyredraw
