" ------------------------------------------------------------------------------
" # Installed Plugins
" ------------------------------------------------------------------------------

" Source all the vim configs
Plug '/Users/jesseleite/Code/vim-sourcery'

" Dump debug all the vim things
Plug 'jesseleite/vim-raymond', {'for': ['vim', 'lua']}

" Human readable vim startup time profiling
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

" Fzf fuzzy finder
Plug '/usr/local/opt/fzf'

" Fzf vim wrapper
Plug 'junegunn/fzf.vim'

" Telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'

" Code commenting
Plug 'tpope/vim-commentary'

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
Plug 'mhinz/vim-signify'

" Git commands
Plug 'tpope/vim-fugitive'

" Github commands
Plug 'tpope/vim-rhubarb'

" Language pack
Plug 'sheerun/vim-polyglot'

" Linters
Plug 'w0rp/ale'

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
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'inside/vim-textobj-function-php', {'for': 'php'}
Plug 'whatyouhide/vim-textobj-xmlattr'

" Share content with carbon.now.sh
Plug 'kristijanhusak/vim-carbon-now-sh'

" Stop repeating basic movement commands
Plug 'takac/vim-hardtime'

" Prime is greatest harpoonist
Plug 'ThePrimeagen/harpoon'

" Explicit annotation bindings for more accurate go to
let g:sourcery#explicit_plugin_bindings = {
  \ '/usr/local/opt/fzf': 'base-fzf',
  \ 'bkad/CamelCaseMotion': 'camel-case-motion',
  \ }


" ------------------------------------------------------------------------------
" # Basic Plugin Configuration
" ------------------------------------------------------------------------------
" # This is for basic plugin config only.  More elaborate plugin config
" # files are located in the /plugin-config folder.

" Config: signify
let g:signify_sign_add = '▍'
let g:signify_sign_change = '▍'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_delete = '▁'

" Config: togglelist
let g:toggle_list_no_mappings = 1

" Config: peekaboo
let g:peekaboo_window = 'vertical botright 60new'

" Config: ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Config: pdv
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"

" Config: vdebug
let g:vdebug_options= {
  \ "port" : 9001,
  \ }

" Config: polyglot
let g:vim_markdown_frontmatter = 1

" Disable unimparied mappings for emmet
" Config: unimpaired
let g:nremap = {"[e": "", "]e": ""}

" Config: targets
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

" Config: easy-align
let g:easy_align_ignore_groups = []

" Config: winmode
let g:win_mode_horizontal_resize_step = 6
let g:win_mode_vertical_resize_step = 2

" Config: better-whitespace
let g:strip_whitespace_confirm = 0

" Config: sneak
let g:sneak#use_ic_scs = 1

" Config: pear-tree
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_ft_disabled = ["TelescopePrompt"]

" Config: hardtime
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 3
let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "<Up>", "<Down>", "<Left>", "<Right>"]
