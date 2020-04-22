" ------------------------------------------------------------------------------
" # Installed Plugins
" ------------------------------------------------------------------------------

" Human readable vim startup time profiling
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

" Fzf fuzzy finder
Plug '/usr/local/opt/fzf'

" Fzf vim wrapper
Plug 'junegunn/fzf.vim'

" Better ag search
Plug 'jesseleite/vim-agriculture'

" Base16 theming architecture
Plug 'chriskempson/base16-vim'

" Status line
Plug 'vim-airline/vim-airline'

" Status line themes
Plug 'vim-airline/vim-airline-themes'

" File system browser
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind']}

" Tag generation
Plug 'ludovicchabant/vim-gutentags'

" Tag browser
Plug 'majutsushi/tagbar'

" Undo tree
Plug 'mbbill/undotree'

" Quickfix/Location toggler
Plug 'milkypostman/vim-togglelist'

" Git gutters
Plug 'airblade/vim-gitgutter'

" Git commands
Plug 'tpope/vim-fugitive'

" Github commands
Plug 'tpope/vim-rhubarb'

" Language pack
Plug 'sheerun/vim-polyglot'

" Linters
Plug 'w0rp/ale'

" Code commenting
Plug 'tpope/vim-commentary'

" CSS colour rendering
Plug 'ap/vim-css-color'

" Test runner
Plug 'janko-m/vim-test'

" Peek into registers
Plug 'junegunn/vim-peekaboo'

" Insert brackets, quotes, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Snippets
Plug 'SirVer/ultisnips'

" Substitute highlighting and preview
Plug 'markonm/traces.vim'

" Highlight and trim whitespace
Plug 'ntpeters/vim-better-whitespace'

" Handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Surround commands
Plug 'tpope/vim-surround'

" Better . repeating
Plug 'tpope/vim-repeat'

" Close buffer without closing window or split
Plug 'moll/vim-bbye'

" Text alignment
Plug 'junegunn/vim-easy-align'

" Vimscript test framework
Plug 'junegunn/vader.vim'

" HTML/CSS expand abbreviation magic
Plug 'mattn/emmet-vim'

" Run terminal commands in interactive shell
Plug 'christoomey/vim-run-interactive'

" Emacs style mappings for ex commands
Plug 'houtsnip/vim-emacscommandline'

" Additional text objects, and better seeking
Plug 'wellle/targets.vim'

" Sneak motion and better f/t motions
Plug 'justinmk/vim-sneak'

" Writable search buffer from quickfix
Plug 'AndrewRadev/writable_search.vim'

" Window resizer
Plug 'hsanson/vim-winmode'

" Automatic search highlight clearing
Plug 'jesseleite/vim-noh'

" Current search match highlighting
Plug 'PeterRincker/vim-searchlight'

" Indent on paste
Plug 'sickill/vim-pasta'

" PHP Help
Plug 'alvan/vim-php-manual', {'for': 'php'}

" PHP docblocks
Plug 'tobyS/pdv', {'for': 'php'}

" Dependency for tobyS/pdv
Plug 'tobyS/vmustache'

" Debugging
Plug 'vim-vdebug/vdebug', {'on': ['Breakpoint', 'VdebugStart']}

" PHP refactoring and introspection
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'inside/vim-textobj-function-php'

" IDE-like autocompletion
" Plug 'Shougo/deoplete.nvim'

" Dependency for Shougo/deoplete.nvim
" Plug 'roxma/nvim-yarp'

" Dependency for Shougo/deoplete.nvim
" Plug 'roxma/vim-hug-neovim-rpc'

" PHP Deoplete Source
" Plug 'kristijanhusak/deoplete-phpactor', {'for': 'php'}

" Explicit annotation bindings for more accurate go to
let g:explicit_annotation_bindings = {
  \ 'fzf': 'fzf.vim',
  \ 'writable-search': 'writable_search.vim',
  \ 'textobj': 'vim-textobj-user',
  \ }


" ------------------------------------------------------------------------------
" # Basic Plugin Configuration
" ------------------------------------------------------------------------------
" # This is for basic plugin config only.  More elaborate plugin config
" # files are located in the /plugin-config folder.

" Plugin: togglelist
let g:toggle_list_no_mappings = 1

" Plugin: nerdtree
let g:NERDTreeWinSize=45
let g:NERDTreeQuitOnOpen = 1

" Plugin: phpactor
let g:phpactorBranch = 'develop'

" Plugin: peekaboo
let g:peekaboo_window = 'vertical botright 60new'

" Plugin: ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Plugin: pdv
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

" Plugin: deoplete
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#source('_', 'max_menu_width', 120)
" call deoplete#custom#option('auto_complete_delay', 600)
" ...Why do these cause boot errors after moving from vimrc to this file?

" Plugin: vdebug
let g:vdebug_options= {
  \ "port" : 9001,
  \ }

" Plugin: polyglot
let g:vim_markdown_frontmatter = 1

" Disable unimparied mappings for emmet
" Plugin: unimpaired
let g:nremap = {"[e": "", "]e": ""}

" Plugin: targets
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

" Plugin: writable-search
let g:writable_search_new_buffer_command = 'enew'

" Plugin: easy-align
let g:easy_align_ignore_groups = []

" Plugin: winmode
let g:win_mode_horizontal_resize_step = 6
let g:win_mode_vertical_resize_step = 2

" Plugin: better-whitespace
let g:strip_whitespace_confirm = 0
