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

" File system explorer
Plug 'lambdalisue/fern.vim' , {'on': 'Fern'}

" Tag generation
Plug 'ludovicchabant/vim-gutentags'

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
Plug 'vim-test/vim-test'

" Peek into registers
Plug 'junegunn/vim-peekaboo'

" Insert brackets, quotes, etc. in pairs
Plug 'tmsvg/pear-tree'

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

" Camel case motions
Plug 'bkad/CamelCaseMotion'

" Writable search buffer from quickfix
Plug 'AndrewRadev/writable_search.vim'

" Window resizer
Plug 'hsanson/vim-winmode'

" Window maximizer
Plug 'szw/vim-maximizer'

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

" LSP intelligence engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" PHP refactoring and introspection
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install', 'branch': 'develop'}

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'inside/vim-textobj-function-php', {'for': 'php'}

" Share content with carbon.now.sh
Plug 'kristijanhusak/vim-carbon-now-sh'

" Explicit annotation bindings for more accurate go to
let g:explicit_annotation_bindings = {
  \ 'fzf': 'fzf.vim',
  \ 'coc': 'coc.nvim',
  \ 'writable-search': 'writable_search.vim',
  \ 'textobj': 'vim-textobj-user',
  \ 'camel-case-motions': 'CamelCaseMotion',
  \ }


" ------------------------------------------------------------------------------
" # Basic Plugin Configuration
" ------------------------------------------------------------------------------
" # This is for basic plugin config only.  More elaborate plugin config
" # files are located in the /plugin-config folder.

" Plugin: togglelist
let g:toggle_list_no_mappings = 1

" Plugin: phpactor
let g:phpactorBranch = 'develop'

" Plugin: peekaboo
let g:peekaboo_window = 'vertical botright 60new'

" Plugin: ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Plugin: pdv
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

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

" Plugin: sneak
let g:sneak#use_ic_scs = 1

" Plugin: pear-tree
let g:pear_tree_repeatable_expand = 0
