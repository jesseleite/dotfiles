" ------------------------------------------------------------------------------
" # Sane Defaults
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
set splitbelow
set splitright
set hlsearch
set title
set ttymouse=xterm2
set cursorline
set cursorlineopt=number
set ignorecase
set smartcase

" Dynamically set titlestring to current project
let currentProject = substitute(getcwd(), '^.*/', '', '')
execute 'set titlestring=vim\ (' . currentProject . ')'

" Set updatetime for CursorHold, etc.
set updatetime=1000

" Auto complete menu options
set completeopt=menu,menuone,noinsert,noselect

" Yeah, it's a package, but it comes with vim
packadd! matchit

" Check for external changes and reload buffer
augroup check_for_external_changes
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if filereadable(bufname('%')) | checktime
augroup END

" Automatically resize vim's windows when resizing vim
augroup equalize_windows_on_resize
  autocmd!
  autocmd VimResized * exec "normal \<c-w>="
augroup END

" Persistent undo
let &undodir=sourcery#system_vimfiles_path('undo')
set undofile
