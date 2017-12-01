set nocompatible

" Plugins

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'           " Base16 theming architecture
Plug 'vim-airline/vim-airline'           " Status line
Plug 'vim-airline/vim-airline-themes'    " Status line themes
Plug 'scrooloose/nerdtree'               " File system browser 
Plug 'ludovicchabant/vim-gutentags'      " Tag generation
Plug 'majutsushi/tagbar'                 " Tag browser
Plug '/usr/local/opt/fzf'                " Fzf fuzzy finder
Plug 'junegunn/fzf.vim'                  " Fzf vim wrapper
Plug 'tpope/vim-fugitive'                " Git commands
Plug 'airblade/vim-gitgutter'            " Git gutters
Plug 'tpope/vim-rhubarb'                 " Github commands
Plug 'sheerun/vim-polyglot'              " Language pack
Plug 'tpope/vim-commentary'              " Code commenting
Plug 'ap/vim-css-color'                  " CSS colour rendering
Plug 'janko-m/vim-test'                  " Test runner
Plug 'jiangmiao/auto-pairs'              " Insert brackets, quotes, etc. in pairs
Plug 'SirVer/ultisnips'                  " Snippets 

call plug#end()

" Mappings

let mapleader = "\<Space>"
imap jk <Esc>
nmap <Leader>\ :NERDTreeToggle<Enter>
nmap <Leader>w :w<Enter>
nmap <Leader>p :GFiles<Enter>
nmap <Leader>P :Files<Enter>
nmap <Leader>r :BTags<Enter>
nmap <Leader>R :Tags<Enter>
nmap <Leader>t :Files<Enter>:BTags<Enter> " wot to remap this to?
nmap <Leader>b :Buffers<Enter>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tn :TestNearest<CR>
nmap <Leader>ss :ownsyntax<Space>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>
let g:UltiSnipsSnippetsDir = "~/.dotfiles/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

xnoremap > >gvh " Smarter indent
xnoremap < <gvh " Smarter unindent

nmap zt zt<C-y><C-y> " Scroll a bit of breathing room before line after zt
nmap zb zb<C-e><C-e> " Scroll a bit of breathing room after line after zb

nnoremap <C-j> :m .+1<Enter>==
nnoremap <C-k> :m .-2<Enter>==
inoremap <C-j> <Esc>:m .+1<Enter>==gi
inoremap <C-k> <Esc>:m .-2<Enter>==gi
vnoremap <C-j> :m '>+1<Enter>gv=gv
vnoremap <C-k> :m '<-2<Enter>gv=gv

" Settings

set autoread
set confirm
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set relativenumber

" Theming

colorscheme base16-monokai
highlight Normal ctermbg=none       " Use terminal background colour
highlight NonText ctermbg=none      " Use terminal background colour
highlight LineNr ctermbg=none       " Override gutter colour
highlight CursorLineNR ctermfg=none " Override gutter colour

" Autocmds

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime " Trigger autoread and/or ask to load file

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
autocmd FileType snippets setlocal ts=4 sw=4 sts=4 expandtab

