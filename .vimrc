set nocompatible
set t_Co=256

" Plugins

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'        " Base16 theming architecture
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'scrooloose/nerdtree'            " File system browser
Plug 'ludovicchabant/vim-gutentags'   " Tag generation
Plug 'majutsushi/tagbar'              " Tag browser
Plug 'mbbill/undotree'                " Undo tree
Plug 'Valloric/ListToggle'            " Quickfix/Location toggler
Plug '/usr/local/opt/fzf'             " Fzf fuzzy finder
Plug 'junegunn/fzf.vim'               " Fzf vim wrapper
Plug 'mileszs/ack.vim'                " Ag search wrapper
Plug 'tpope/vim-fugitive'             " Git commands
Plug 'airblade/vim-gitgutter'         " Git gutters
Plug 'tpope/vim-rhubarb'              " Github commands
Plug 'sheerun/vim-polyglot'           " Language pack
Plug 'vim-syntastic/syntastic'        " Linter wrapper
Plug 'tpope/vim-commentary'           " Code commenting
Plug 'ap/vim-css-color'               " CSS colour rendering
Plug 'janko-m/vim-test'               " Test runner
Plug 'jiangmiao/auto-pairs'           " Insert brackets, quotes, etc. in pairs
Plug 'SirVer/ultisnips'               " Snippets
Plug 'ntpeters/vim-better-whitespace' " Highlight and trim whitespace
Plug 'mattn/emmet-vim'                " HTML/CSS expand abbreviation magic
Plug 'tpope/vim-surround'             " Surround commands
Plug 'qpkorr/vim-bufkill'             " Close buffer without closing window or split
Plug 'junegunn/goyo.vim'              " Distraction free writing
Plug 'junegunn/limelight.vim'         " Hyper focus writing
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'tobyS/vmustache'                " PHP docblocks dependency
Plug 'tobyS/pdv'                      " PHP docblocks
Plug 'arnaud-lb/vim-php-namespace'    " PHP namespace importer

call plug#end()

" Mappings

let mapleader = "\<Space>"
imap jk <Esc>
cnoremap jk <C-c>
nmap <Leader><Leader>v :Vimrc<CR>
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
nmap <Leader><Tab> :NERDTreeToggle<CR>
nmap <Leader><Leader><Tab> :NERDTree<CR>
nmap <Leader><Leader><Tab>f :NERDTreeFind<CR>
nmap <Leader>\ :TagbarToggle<CR>
nmap <Leader>u :UndotreeToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>p :GFiles<CR>
nmap <Leader>P :Files<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>R :Tags<CR>
nmap <Leader>t :Files<CR>:BTags<CR> " wot to remap this to?
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>s :Snippets<CR>
nmap <Leader>d ddO<Esc>
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

" The GitGutter leader mappings are a bit intrusive, so only map what I use.
let g:gitgutter_map_keys=0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:BufKillCreateMappings = 0

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

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

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ackhighlight = 1
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=PSR2 -n'
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = '!'
let g:syntastic_style_warning_symbol = '!'

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
highlight SyntasticErrorSign ctermbg=none ctermfg=red
highlight SyntasticWarningSign ctermbg=none ctermfg=magenta
highlight SyntasticStyleErrorSign ctermbg=none ctermfg=red
highlight SyntasticStyleWarningSign ctermbg=none ctermfg=magenta

" Commands

command! Vimrc edit $MYVIMRC
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Auto Commands

augroup autocommands
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime " Trigger autoread and/or ask to load file
  autocmd BufEnter * EnableStripWhitespaceOnSave
  autocmd BufReadPost quickfix nested setlocal modifiable
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

augroup filetypesettings
  autocmd!
  autocmd FileType javascript setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType vue setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s
  autocmd FileType vue syntax sync fromstart
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

if !exists("*s:goyo_enter")
  function! s:goyo_enter()
    Limelight
  endfunction
endif

if !exists("*s:goyo_leave")
  function! s:goyo_leave()
    Limelight!
    so $MYVIMRC
  endfunction
endif

let g:limelight_conceal_ctermfg = 'black'

map <D-s> <Esc>:w<CR>
map <M-s> <Esc>:w<CR>
map <C-s> <Esc>:w<CR>

if has("gui_running")
  set guioptions=
  set guifont=Menlo\ LG100
endif

" rr ag function ideas?
" --ignore-dir resources/assets/js/vendors
