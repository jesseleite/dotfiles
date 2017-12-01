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
nnoremap <Esc> :nohlsearch<CR><Esc>
nmap <Leader>\ :NERDTreeToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>p :GFiles<CR>
nmap <Leader>P :Files<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>R :Tags<CR>
nmap <Leader>t :Files<CR>:BTags<CR> " wot to remap this to?
nmap <Leader>b :Buffers<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tn :TestNearest<CR>
nmap <Leader>ss :ownsyntax<Space>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nmap zt zt<C-y><C-y> " Scroll a bit of breathing room before line after zt
nmap zb zb<C-e><C-e> " Scroll a bit of breathing room after line after zb

xnoremap > >gvh " Smarter indent
xnoremap < <gvh " Smarter unindent

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Settings

set autoread
set confirm
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set relativenumber
set incsearch

" Theming

"let base16colorspace=256
colorscheme base16-monokai
set hlsearch
highlight Normal ctermbg=none                  " Use terminal background colour
highlight NonText ctermbg=none                 " Use terminal background colour
highlight LineNr ctermbg=none                  " Override gutter colour
highlight CursorLineNR ctermfg=none            " Override gutter colour
highlight Search ctermbg=blue ctermfg=white    " Override search match highlighting
highlight Visual ctermbg=black ctermfg=white   " Override visual highlighing

" Commands

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Auto Commands

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
autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s
autocmd FileType snippets setlocal ts=4 sw=4 sts=4 expandtab

