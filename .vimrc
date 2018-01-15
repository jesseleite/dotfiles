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
Plug 'mileszs/ack.vim'                   " Ag search wrapper
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
Plug 'tpope/vim-surround'                " Surround commands
Plug 'qpkorr/vim-bufkill'                " Close buffer without closing window or split

call plug#end()

" Mappings

let mapleader = "\<Space>"
imap jk <Esc>
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
nmap <Leader>\ :NERDTreeToggle<CR>
nmap <Leader>\| :NERDTree<CR>
nmap <Leader>\|f :NERDTreeFind<CR>
nmap <Leader>\|t :TagbarToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>p :GFiles<CR>
nmap <Leader>P :Files<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>R :Tags<CR>
nmap <Leader>t :Files<CR>:BTags<CR> " wot to remap this to?
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>s :Snippets<CR>
nmap <Leader>o o<Esc>O
nmap <Leader>ss :Filetypes<CR>
nmap <Leader>ts :w<CR>:TestSuite<CR>
nmap <Leader>tf :w<CR>:TestFile<CR>
nmap <Leader>tl :w<CR>:TestLast<CR>
nmap <Leader>tn :w<CR>:TestNearest<CR>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

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

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:BufKillCreateMappings = 0

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
call matchadd('ColorColumn', '\%121v', 100)    " Only show 121st character on lines that might exceed 120
let g:NERDTreeWinSize=45
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ackhighlight = 1
endif

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
highlight ColorColumn ctermbg=black                          " Highlighting
highlight GitGutterAdd ctermbg=none ctermfg=green             " Git gutter
highlight GitGutterChange ctermbg=none ctermfg=yellow         " Git gutter
highlight GitGutterDelete ctermbg=none ctermfg=red            " Git gutter
highlight GitGutterChangeDelete ctermbg=none ctermfg=red      " Git gutter
highlight VertSplit ctermbg=none ctermfg=none                 " Vert split
highlight CursorLine ctermbg=black ctermfg=none               " Cursor line for nerd tree?
highlight QuickFixLine ctermbg=black ctermfg=none             " Quickfix selection

" Commands

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Auto Commands

augroup autocommands
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime " Trigger autoread and/or ask to load file
  autocmd BufEnter * EnableStripWhitespaceOnSave
  autocmd BufReadPost quickfix nested setlocal modifiable
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

" Experimenting

" Need this for now, because git-gutter messes with my `<Leader>h` mapping :(
nmap <Leader>ghr <Plug>GitGutterUndoHunk:echomsg ' hr is deprecated. Use hu'<CR>
nmap <Leader>ghp <Plug>GitGutterPreviewHunk
nmap <Leader>ghs <Plug>GitGutterStageHunk
nmap <Leader>ghu <Plug>GitGutterUndoHunk
