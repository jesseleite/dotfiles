set nocompatible
set t_Co=256

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
Plug 'tobyS/vmustache'                   " PHP docblocks dependency
Plug 'tobyS/pdv'                         " PHP docblocks
Plug 'ntpeters/vim-better-whitespace'    " Highlight and trim whitespace
Plug 'mattn/emmet-vim'                   " HTML/CSS expand abbreviation magic

call plug#end()

" Mappings

let mapleader = "\<Space>"
imap jk <Esc>
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
nmap <Leader>\ :NERDTreeToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>p :GFiles<CR>
nmap <Leader>P :Files<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>R :Tags<CR>
nmap <Leader>t :Files<CR>:BTags<CR> " wot to remap this to?
nmap <Leader>b :Buffers<CR>
nmap <Leader>s :Snippets<CR>
nmap <Leader>ss :Filetypes<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tn :TestNearest<CR>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nnoremap <Leader>/** :call pdv#DocumentWithSnip()<CR>

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

set hidden
set autoread
set confirm
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set relativenumber
set incsearch
set fillchars+=vert:\ ,                        " Vertical split character
let g:NERDTreeWinSize=60
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

" Theming

"let base16colorspace=256
colorscheme base16-monokai
set hlsearch
highlight Normal ctermbg=none                                 " Use terminal background
highlight NonText ctermbg=none                                " Use terminal background
highlight Search ctermbg=blue ctermfg=white                   " Search matches
highlight Visual ctermbg=black ctermfg=white                  " Visual selection
highlight LineNr ctermbg=none                                 " Gutter
highlight CursorLineNR ctermbg=green ctermfg=none             " Gutter
highlight SignColumn ctermbg=none                             " Git gutter
highlight GitGutterAdd ctermbg=none ctermfg=green             " Git gutter
highlight GitGutterChange ctermbg=none ctermfg=yellow         " Git gutter
highlight GitGutterDelete ctermbg=none ctermfg=red            " Git gutter
highlight GitGutterChangeDelete ctermbg=none ctermfg=red      " Git gutter
highlight VertSplit ctermbg=none ctermfg=none                 " Vert split

" Commands

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Auto Commands

augroup autocommands
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime " Trigger autoread and/or ask to load file
  autocmd BufEnter * EnableStripWhitespaceOnSave
augroup END

augroup filetypesettings
  autocmd!
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
augroup END
