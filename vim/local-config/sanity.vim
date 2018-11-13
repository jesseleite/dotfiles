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
set updatetime=1000                            " Set updatetime for CursorHold, gitgutter, etc.
set completeopt=menu,menuone,noinsert,noselect " Auto complete menu options
" set lazyredraw                               " Had this for some reason, but it causes deoplete flicker

augroup check_for_external_changes
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
augroup END
