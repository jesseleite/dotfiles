" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim


" ------------------------------------------------------------------------------
" # Plugins
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'               " Fzf fuzzy finder
Plug 'junegunn/fzf.vim'                 " Fzf vim wrapper
Plug 'jesseleite/vim-agriculture'       " Better ag search
Plug 'chriskempson/base16-vim'          " Base16 theming architecture
Plug 'vim-airline/vim-airline'          " Status line
Plug 'vim-airline/vim-airline-themes'   " Status line themes
Plug 'scrooloose/nerdtree'              " File system browser
Plug 'ludovicchabant/vim-gutentags'     " Tag generation
Plug 'majutsushi/tagbar'                " Tag browser
Plug 'mbbill/undotree'                  " Undo tree
Plug 'Valloric/ListToggle'              " Quickfix/Location toggler
Plug 'airblade/vim-gitgutter'           " Git gutters
Plug 'tpope/vim-fugitive'               " Git commands
Plug 'tpope/vim-rhubarb'                " Github commands
Plug 'sheerun/vim-polyglot'             " Language pack
Plug 'w0rp/ale'                         " Linters
Plug 'tpope/vim-commentary'             " Code commenting
Plug 'ap/vim-css-color'                 " CSS colour rendering
Plug 'janko-m/vim-test'                 " Test runner
Plug 'junegunn/vim-peekaboo'            " Peek into registers
Plug 'jiangmiao/auto-pairs'             " Insert brackets, quotes, etc. in pairs
Plug 'SirVer/ultisnips'                 " Snippets
Plug 'markonm/traces.vim'               " Substitute highlighting and preview
Plug 'ntpeters/vim-better-whitespace'   " Highlight and trim whitespace
Plug 'tpope/vim-unimpaired'             " Handy bracket mappings
Plug 'tpope/vim-surround'               " Surround commands
Plug 'tpope/vim-repeat'                 " Better . repeating
Plug 'qpkorr/vim-bufkill'               " Close buffer without closing window or split
Plug 'junegunn/goyo.vim'                " Distraction free writing
Plug 'junegunn/limelight.vim'           " Hyper focus writing
Plug 'junegunn/vim-easy-align'          " Text alignment
Plug 'junegunn/vader.vim'               " Vimscript test framework
Plug 'tobyS/vmustache'                  " PHP docblocks dependency
Plug 'tobyS/pdv'                        " PHP docblocks
Plug 'mattn/emmet-vim'                  " HTML/CSS expand abbreviation magic
Plug 'Shougo/deoplete.nvim'             " IDE-like autocompletion
Plug 'roxma/nvim-yarp'                  " Deoplete dependency
Plug 'roxma/vim-hug-neovim-rpc'         " Deoplete dependency
Plug 'phpactor/phpactor',               " PHP refactoring and introspection
  \ { 'for': 'php', 'do': 'composer install' }
Plug 'kristijanhusak/deoplete-phpactor' " PHP Deoplete source
Plug 'vim-vdebug/vdebug'                " Debugging

call plug#end()

packadd! matchit


" ------------------------------------------------------------------------------
" # Mappings
" ------------------------------------------------------------------------------

" Leader
let mapleader = "\<Space>"

" Esc / Ctrl-c
imap jk <Esc>
cnoremap jk <C-c>

" Clear search highlighting
nmap <silent> <Leader>jk :nohlsearch<CR>

" Write
nmap <Leader>w :w<CR>
imap jw <Esc>:w<CR>
map <D-s> <Esc>:w<CR>
map <M-s> <Esc>:w<CR>
map <C-s> <Esc>:w<CR>

" Write and reload current tab in chrome
nmap <silent> <Leader>R :w<CR>:execute "!chrome-cli reload"<CR>:redraw!<CR>

" Write and source, for plugin development?
nmap <Leader><Leader>w :w<CR>:so %<CR>

" Edit .vimrc
nmap <Leader><Leader>v :edit $MYVIMRC<CR>
nmap <Leader><Leader>V :source $MYVIMRC<CR>

" Open in finder
nmap <silent> <Leader><Leader>o :!open $PWD<CR><CR>

" Browse with valet open
nmap <silent> <Leader><Leader>b :!valet open<CR><CR>

" Windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <Leader>o <C-w>o

" Close buffer, and disable intrusive BuffKill mappings
let g:BufKillCreateMappings = 0
nmap <silent> <Leader>c :BD<CR>

" Switch to last opened buffer
nmap <Leader>- <C-^>

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
nmap <Leader>a :AgRaw<Space>

" Artisan
nmap <Leader><Leader>a :!php artisan<Space>

" Run tests
nmap <Leader>rt :w<CR>:TestToggleStrategy<CR>
nmap <Leader>rs :w<CR>:TestSuite<CR>
nmap <Leader>rf :w<CR>:TestFile<CR>
nmap <Leader>rl :w<CR>:TestLast<CR>
nmap <Leader>rn :w<CR>:TestNearest<CR>
nmap <Leader>rv :w<CR>:TestVisit<CR>

" Git / Github
nmap <Leader>G :Gstatus<CR>
nmap <Leader><Leader>G :Gbrowse<CR>

" Panel toggles
nmap <Leader><Tab> :NERDTreeToggle<CR>
nmap <Leader><Leader><Tab> :NERDTree<CR>
nmap <Leader><Leader><Tab>f :NERDTreeFind<CR>zz
nmap <Leader>\ :TagbarToggle<CR>
nmap <Leader><Leader>u :UndotreeToggle<CR>
let g:lt_quickfix_list_toggle_map = '<Leader><Leader>q'
let g:lt_location_list_toggle_map = '<Leader><Leader>l'

" Delete text on line
nmap <Leader>d 0D

" Open lines, but stay in normal mode
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Open line below, with an extra blank line below that one
nnoremap <Leader><CR> o<C-o>O

" Quickly append semicolon or comma
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

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

" Phpactor
nnoremap <Leader>p :call phpactor#ContextMenu()<CR>
nnoremap <Leader>pg :call phpactor#GotoDefinition()<CR>
nnoremap <Leader>pi :call phpactor#UseAdd()<CR>
nnoremap <Leader>pt :call phpactor#Transform()<CR>

" PHP docblocks
nnoremap <Leader>D :call pdv#DocumentWithSnip()<CR>

" Disable unimpaired mappings
let g:nremap = {"[e": "", "]e": ""}

" Emmet
imap <C-e> <plug>(emmet-expand-abbr)
nmap ]e <plug>(emmet-move-next)
nmap [e <plug>(emmet-move-prev)

" Vdebug
nnoremap <Leader>B :Breakpoint<CR>
nnoremap <Leader>V :VdebugStart<CR>


" ------------------------------------------------------------------------------
" # Settings
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
" set lazyredraw                               " Had this for some reason, but it causes deoplete flicker
set updatetime=1000                            " Set updatetime for CursorHold, gitgutter, etc.
set fillchars+=vert:\ ,                        " Vertical split character
call matchadd('ColorColumn', '\%121v', 100)    " Only show 121st character on lines that might exceed 120
set completeopt=menu,menuone,noinsert,noselect " Auto complete menu options

" Always insert completion popup candidate without entering new line.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

let g:airline_theme='base16color'

let g:NERDTreeWinSize=45
let g:NERDTreeQuitOnOpen = 1

let g:peekaboo_window = 'vertical botright 60new'

let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

let g:ale_sign_error = '!'
let g:ale_sign_style_error = '!'
let g:ale_sign_warning = '!'
let g:ale_sign_style_warning = '!'

let g:ale_linters = {
  \ 'php': ['php', 'phpcs', 'phpmd'],
  \ }

let g:ale_php_phpcs_standard = 'PSR2'

let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_menu_width', 120)
call deoplete#custom#option('auto_complete_delay', 600)

let g:phpactorBranch = 'develop'

let g:vdebug_options= {
  \ "port" : 9001,
  \ }

let test#php#patterns = {
  \ 'test':      ['\v^\s*function (\w*)\('],
  \ 'namespace': [] }

let g:vim_markdown_frontmatter = 1


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
highlight CursorLineNR ctermbg=green ctermfg=green
highlight SignColumn ctermbg=none
highlight ColorColumn ctermbg=black
highlight GitGutterAdd ctermbg=none ctermfg=green
highlight GitGutterChange ctermbg=none ctermfg=yellow
highlight GitGutterDelete ctermbg=none ctermfg=red
highlight GitGutterChangeDelete ctermbg=none ctermfg=red
highlight VertSplit ctermbg=none ctermfg=none
highlight StatusLine ctermfg=none ctermbg=none
highlight StatusLineNC ctermfg=none ctermbg=none
highlight CursorLine ctermbg=black ctermfg=none
highlight QuickFixLine ctermbg=black ctermfg=none
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEWarningSign ctermbg=none ctermfg=magenta
highlight Pmenu ctermfg=grey ctermbg=black
highlight PmenuSel ctermfg=white ctermbg=blue
highlight PmenuSbar ctermbg=black
highlight PmenuThumb ctermbg=white


" ------------------------------------------------------------------------------
" # Functions
" ------------------------------------------------------------------------------

function! PlaybackMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! GoToPluginOnGithub()
  normal ^f/"vyi'
  execute "!chrome-cli open https://www.github.com/" . @v
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
  autocmd BufReadPost $MYVIMRC nnoremap <leader>g :call GoToPluginOnGithub()<CR><CR>
  autocmd BufWinEnter * if &l:buftype ==# 'help' | wincmd o | endif
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
  autocmd BufEnter * EnableStripWhitespaceOnSave
  autocmd BufReadPost quickfix nested nmap <buffer> <CR> <CR>
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

augroup filetype_settings
  autocmd!
  autocmd FileType zsh setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType vim setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s omnifunc=phpactor#Complete
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

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Label'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Label'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Function'],
  \ 'pointer': ['fg', 'Statement'],
  \ 'marker':  ['fg', 'Conditional'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! Mapsn call fzf#vim#maps('n', 0)
command! Mapsx call fzf#vim#maps('x', 0)
command! Mapso call fzf#vim#maps('o', 0)
command! Mapsi call fzf#vim#maps('i', 0)
command! Mapsv call fzf#vim#maps('v', 0)
command! Mapsa call fzf#vim#maps('a', 0)


" ------------------------------------------------------------------------------
" # Shtuff
" ------------------------------------------------------------------------------

function! ShtuffStrategy(cmd)
  call system("shtuff into " . shellescape(g:shtuff_as) . " " . shellescape("clear;" . a:cmd))
endfunction

function! TestToggleStrategy()
  if exists("g:test#strategy")
    unlet g:test#strategy
    echo "Test Strategy: default"
  else
    let g:test#strategy = "shtuff"
    echo "Test Strategy: shtuff into test"
  endif
endfunction

command! TestToggleStrategy call TestToggleStrategy()

let g:shtuff_as = "test"
let g:test#custom_strategies = {'shtuff': function('ShtuffStrategy')}

if match(system('shtuff has test'), 'was found') > 0
  let g:test#strategy = "shtuff"
elseif exists('g:test#strategy')
  unlet g:test#strategy
endif


" ------------------------------------------------------------------------------
" # Experimenting
" ------------------------------------------------------------------------------

function! RecordGif()
  let g:fzf_layout = { 'down': '~55%' }
  :ALEDisable
endfunction
command! RecordGif silent! call RecordGif()

augroup goyo_events
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

let g:limelight_conceal_ctermfg = 'black'

if !exists("*s:goyo_enter")
  function! s:goyo_enter()
    nnoremap j gj
    nnoremap k gk
    Limelight
  endfunction
endif

if !exists("*s:goyo_leave")
  function! s:goyo_leave()
    nunmap j
    nunmap k
    Limelight!
    so $MYVIMRC
  endfunction
endif

if has("gui_running")
  set guioptions=
  set guifont=Menlo\ LG100
endif

" command! -bang -nargs=+ Methods
"   \ call fzf#vim#buffer_tags(<q-args>, { 'options': ['--nth', '..-2,-1', '--query', '^f$ '] })

" When using `dd` in the quickfix list, remove the item from the quickfix list.
" https://stackoverflow.com/questions/42905008/quickfix-list-how-to-add-and-remove-entries

function! RemoveQuickfixItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction

autocmd FileType qf map <buffer> dd :call RemoveQuickfixItem()<cr>
