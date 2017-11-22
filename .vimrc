call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'           " base16 theming architecture
"Plug 'vim-airline/vim-airline'           " Status line
"Plug 'vim-airline/vim-airline-themes'    " Status line themes
Plug 'scrooloose/nerdtree'               " File system explorer 
Plug '/usr/local/opt/fzf'                " Fzf fuzzy finder
Plug 'junegunn/fzf.vim'                  " Fzf vim wrapper
Plug 'tpope/vim-fugitive'                " Git commands
Plug 'airblade/vim-gitgutter'            " Git gutters
Plug 'tpope/vim-rhubarb'                 " Github commands
Plug 'sheerun/vim-polyglot'              " Language pack
Plug 'ap/vim-css-color'                  " CSS colour rendering

call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
nmap <Leader>\ :NERDTreeToggle<Enter>
nmap <Leader>w :w<Enter>
"vmap <Leader>y :! pbcopy<Enter>
nmap <Leader>p :Files<Enter>
nmap <Leader>r :BTags<Enter>
nmap <Leader>t :Files<Enter>:BTags<Enter>
nmap <Leader>b :Buffers<Enter>
nmap <M-p> :Files<Enter>
nmap <D-p> :Files<Enter>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

set encoding=utf-8
set backspace=indent,eol,start
set relativenumber
syntax enable
colorscheme base16-monokai
highlight Normal ctermbg=none  " Use terminal background colour
highlight NonText ctermbg=none " Use terminal background colour
highlight LineNr ctermbg=none
highlight CursorLineNR ctermfg=none

augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

autocmd FileType javascript setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType vue setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType scss setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType css setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType vim setlocal ts=2 sw=2 sts=2 expandtab
autocmd FileType zsh setlocal ts=2 sw=2 sts=2 expandtab
autocmd FileType less setlocal ts=2 sw=2 sts=2 expandtab
autocmd FileType html setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab
