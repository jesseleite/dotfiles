set nocompatible
set t_Co=256


" ------------------------------------------------------------------------------
" # Plugins
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'             " Fzf fuzzy finder
Plug 'junegunn/fzf.vim'               " Fzf vim wrapper
Plug 'jesseleite/vim-agriculture'     " Better ag search
Plug 'chriskempson/base16-vim'        " Base16 theming architecture
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'scrooloose/nerdtree'            " File system browser
Plug 'ludovicchabant/vim-gutentags'   " Tag generation
Plug 'majutsushi/tagbar'              " Tag browser
Plug 'mbbill/undotree'                " Undo tree
Plug 'Valloric/ListToggle'            " Quickfix/Location toggler
Plug 'airblade/vim-gitgutter'         " Git gutters
Plug 'tpope/vim-fugitive'             " Git commands
Plug 'tpope/vim-rhubarb'              " Github commands
Plug 'sheerun/vim-polyglot'           " Language pack
Plug 'vim-syntastic/syntastic'        " Linter wrapper
Plug 'tpope/vim-commentary'           " Code commenting
Plug 'ap/vim-css-color'               " CSS colour rendering
Plug 'janko-m/vim-test'               " Test runner
Plug 'junegunn/vim-peekaboo'          " Peek into registers
Plug 'jiangmiao/auto-pairs'           " Insert brackets, quotes, etc. in pairs
Plug 'ervandew/supertab'              " Tab completion
Plug 'SirVer/ultisnips'               " Snippets
Plug 'xtal8/traces.vim'               " Substitute highlighting and preview
Plug 'ntpeters/vim-better-whitespace' " Highlight and trim whitespace
Plug 'tpope/vim-unimpaired'           " Handy bracket mappings
Plug 'tpope/vim-surround'             " Surround commands
Plug 'tpope/vim-repeat'               " Better . repeating
Plug 'qpkorr/vim-bufkill'             " Close buffer without closing window or split
Plug 'junegunn/goyo.vim'              " Distraction free writing
Plug 'junegunn/limelight.vim'         " Hyper focus writing
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'junegunn/vader.vim'             " Vimscript test framework
Plug 'tobyS/vmustache'                " PHP docblocks dependency
Plug 'tobyS/pdv'                      " PHP docblocks
Plug 'arnaud-lb/vim-php-namespace'    " PHP namespace importer
Plug 'mattn/emmet-vim'                " HTML/CSS expand abbreviation magic

call plug#end()


" ------------------------------------------------------------------------------
" # Mappings
" ------------------------------------------------------------------------------

" Leader
let mapleader = "\<Space>"

" Esc / Ctrl-c
imap jk <Esc>
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
cnoremap jk <C-c>

" Write
nmap <Leader>w :w<CR>
imap jw <Esc>:w<CR>
map <D-s> <Esc>:w<CR>
map <M-s> <Esc>:w<CR>
map <C-s> <Esc>:w<CR>

" Write and reload chrome
nmap <silent> <Leader>R :w<CR>:execute "!chrome-cli reload"<CR>:redraw!<CR>

" Write and source, for plugin development?
nmap <Leader><Leader>w :w<CR>:so %<CR>

" Edit .vimrc
nmap <Leader><Leader>v :edit $MYVIMRC<CR>
nmap <Leader><Leader>V :source $MYVIMRC<CR>

" Windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <Leader>o <C-w>o

" Close buffer, and disable intrusive BuffKill mappings
let g:BufKillCreateMappings = 0
nmap <silent> <Leader>c :BD<CR>

" Next/prev git change, and disable intrusive GitGutter mappings
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" Fzf fuzzy finders
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
" nmap <Leader>m :Methods<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>h :History<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>/ :History/<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>M :Maps<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>s :Filetypes<CR>
nmap <Leader>S :Snippets<CR>

" Ag search project
nmap <Leader>a :Ag<Space>

" Run tests
nmap <Leader>rs :w<CR>:TestSuite<CR>
nmap <Leader>rf :w<CR>:TestFile<CR>
nmap <Leader>rl :w<CR>:TestLast<CR>
nmap <Leader>rn :w<CR>:TestNearest<CR>

" Git / Github
nmap <Leader>gbr :Gbrowse<CR>
nmap <Leader>gbl :Gblame<CR>

" Panel toggles
nmap <Leader><Tab> :NERDTreeToggle<CR>
nmap <Leader><Leader><Tab> :NERDTree<CR>
nmap <Leader><Leader><Tab>f :NERDTreeFind<CR>zz
nmap <Leader>\ :TagbarToggle<CR>
nmap <Leader><Leader>u :UndotreeToggle<CR>
let g:lt_quickfix_list_toggle_map = '<Leader><Leader>q'
let g:lt_location_list_toggle_map = '<Leader><Leader>l'

" Delete text on line
nmap <Leader>d ddO<Esc>

" Open lines, but stay in normal mode
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Quickly append semicolon or comma
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Add a bit of breathing room around zt and zb
nmap zt zt<C-y><C-y>
nmap zb zb<C-e><C-e>

" Keep visual selection when indenting
xnoremap > >gv
xnoremap < <gv

" Move line(s) up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Quicker macro playback
nnoremap Q @q<CR>
xnoremap Q :norm @q<CR>
xnoremap @ :<C-u>call PlaybackMacroOverVisualRange()<CR>

" Break undo sequence on specific characters
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" EasyAlign
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" UltiSnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Generate PHP docblock
nnoremap <Leader>D :call pdv#DocumentWithSnip()<CR>

" Disable unimpaired mappings
let g:nremap = {"[e": "", "]e": ""}

" Emmet
imap <C-e> <plug>(emmet-expand-abbr)
nmap ]e <plug>(emmet-move-next)
nmap [e <plug>(emmet-move-prev)


" ------------------------------------------------------------------------------
" # Settings
" ------------------------------------------------------------------------------

set hidden
set nobackup
set noswapfile
set autoread
set confirm
set wildmenu
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set relativenumber
set incsearch
set fillchars+=vert:\ ,                        " Vertical split character
call matchadd('ColorColumn', '\%121v', 100)    " Only show 121st character on lines that might exceed 120

let g:NERDTreeWinSize=45

let g:peekaboo_window = 'vertical botright 60new'

let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=PSR2 -n'
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = '!'
let g:syntastic_style_warning_symbol = '!'


" ------------------------------------------------------------------------------
" # Theming
" ------------------------------------------------------------------------------

"let base16colorspace=256
colorscheme base16-monokai
set hlsearch
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight Search ctermbg=blue ctermfg=white
highlight Visual ctermbg=black ctermfg=white
highlight LineNr ctermbg=none
highlight CursorLineNR ctermbg=green ctermfg=none
highlight SignColumn ctermbg=none
highlight ColorColumn ctermbg=black
highlight GitGutterAdd ctermbg=none ctermfg=green
highlight GitGutterChange ctermbg=none ctermfg=yellow
highlight GitGutterDelete ctermbg=none ctermfg=red
highlight GitGutterChangeDelete ctermbg=none ctermfg=red
highlight VertSplit ctermbg=none ctermfg=none
highlight CursorLine ctermbg=black ctermfg=none
highlight QuickFixLine ctermbg=black ctermfg=none
highlight SyntasticErrorSign ctermbg=none ctermfg=red
highlight SyntasticWarningSign ctermbg=none ctermfg=magenta
highlight SyntasticStyleErrorSign ctermbg=none ctermfg=red
highlight SyntasticStyleWarningSign ctermbg=none ctermfg=magenta


" ------------------------------------------------------------------------------
" # Functions
" ------------------------------------------------------------------------------

function! PlaybackMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" ------------------------------------------------------------------------------
" # Commands
" ------------------------------------------------------------------------------

" [crickets]


" ------------------------------------------------------------------------------
" # Auto Commands
" ------------------------------------------------------------------------------

augroup misc_commands
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd BufWinEnter * if &l:buftype ==# 'help' | wincmd o | endif
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
  autocmd BufEnter * EnableStripWhitespaceOnSave
  autocmd BufReadPost quickfix nested nmap <buffer> <CR> <CR>
augroup END

augroup filetype_settings
  autocmd!
  autocmd FileType zsh setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType vim setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s
  autocmd FileType html setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType css setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType scss setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType less setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType javascript setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType vue setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s
  autocmd FileType vue syntax sync fromstart
  autocmd FileType snippets setlocal ts=4 sw=4 sts=4 expandtab
augroup END


" ------------------------------------------------------------------------------
" # Fzf
" ------------------------------------------------------------------------------

command! -bang -nargs=+ -complete=dir Ag call fzf#vim#ag_raw(agriculture#smart_quote_input(<q-args>), <bang>0)


" ------------------------------------------------------------------------------
" # Experimenting
" ------------------------------------------------------------------------------

" Hacky workaround to Hyper from pasting clipboard randomly when opening buffers
augroup hyper_hacks
  autocmd!
  autocmd VimEnter * silent! earlier 1f
augroup END

function! RecordGif()
  let g:fzf_layout = { 'down': '~55%' }
  let g:syntastic_mode_map = { 'mode': 'passive' }
  :SyntasticReset
endfunction
command! RecordGif silent! call RecordGif()

augroup goyo_events
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

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

if has("gui_running")
  set guioptions=
  set guifont=Menlo\ LG100
endif

" command! -bang -nargs=+ Methods
"   \ call fzf#vim#buffer_tags(<q-args>, { 'options': ['--nth', '..-2,-1', '--query', '^f$ '] })
