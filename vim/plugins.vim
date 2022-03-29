" ------------------------------------------------------------------------------
" # Installed Plugins
" ------------------------------------------------------------------------------

" Source all the vim configs
Plug 'jesseleite/vim-sourcery'

" Dump debug all the vim things
Plug 'jesseleite/vim-raymond'
Plug 'jesseleite/vim-tinkeray'

" Human readable vim startup time profiling
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Fallback for languages without good treesitter implementations
" Plug 'sheerun/vim-polyglot'

" Telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-rg.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'

" Prime is the greatest harpoonist of all time
Plug 'ThePrimeagen/harpoon'

" Code commenting
Plug 'tpope/vim-commentary'

" Git commands
Plug 'tpope/vim-fugitive'

" Github commands
Plug 'tpope/vim-rhubarb'

" Git gutters
Plug 'mhinz/vim-signify'

" Inline git blame
" Plug 'APZelos/blamer.nvim'
" Plug 'f-person/git-blame.nvim'

" Base16 theming architecture
Plug 'chriskempson/base16-vim'

" Status line
Plug 'vim-airline/vim-airline'

" Status line themes
Plug 'vim-airline/vim-airline-themes'

" File system explorer
Plug 'lambdalisue/fern.vim' , {'on': 'Fern'}

" Neovim LSP
Plug 'neovim/nvim-lspconfig'

" Auto completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Tag generation
" Plug 'ludovicchabant/vim-gutentags'

" Undo tree
Plug 'mbbill/undotree'

" Quickfix/Location toggler
Plug 'milkypostman/vim-togglelist'

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

" Markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" PHP docblocks
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv', {'for': 'php'}

" Debugging (look into dap)
Plug 'vim-vdebug/vdebug', {'on': ['Breakpoint', 'VdebugStart']}

" PHP refactoring and introspection
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

" Share content with carbon.now.sh
Plug 'kristijanhusak/vim-carbon-now-sh'

" Stop repeating basic movement commands
" Plug 'takac/vim-hardtime'

" Cheat.sh
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" Delete the hell outta this if/when my `:Telescope live_grep_raw` PR gets merged!
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'

" Scrollbars
Plug 'Xuyuanp/scrollbar.nvim'

" Code formatter
Plug 'sbdchd/neoformat'

" Github Copilot
" Plug 'github/copilot.vim'

" Explicit annotation bindings for more accurate go to
let g:sourcery#explicit_plugin_bindings = {
  \ '/opt/homebrew/opt/fzf': 'base-fzf',
  \ 'bkad/CamelCaseMotion': 'camel-case-motion',
  \ }


" ------------------------------------------------------------------------------
" # Basic Plugin Configuration
" ------------------------------------------------------------------------------
" # This is for basic plugin config only. More elaborate config files
" # are located in the /config folder.

" Config: sourcery
let g:sourcery#annotation_types = [
  \ 'Mappings',
  \ 'Config',
  \ 'Highlights',
  \ ]

" Config: signify
let g:signify_priority = 1
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

" Disable mappings for emmet
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
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:current_line_whitespace_disabled_soft = 1

" Config: sneak
let g:sneak#use_ic_scs = 1

" Config: pear-tree
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_ft_disabled = ["TelescopePrompt"]

" Config: hardtime
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 3
let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "<Up>", "<Down>", "<Left>", "<Right>"]

" Config: blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1500
let g:blamer_relative_time = 1
let g:blamer_prefix = '    ■ '
let g:blamer_template = '<committer>, <committer-time>: <summary>'
let g:blamer_show_in_insert_modes = 0

" Config: git-blame
let g:gitblame_message_template = '    ■ <summary> • <date> • <author>'
let g:gitblame_date_format = '%r'

" Config: emmet
" I actually want to be able to disable this thought... https://github.com/mattn/emmet-vim/issues/528
let g:user_emmet_leader_key = '<C-Z>'
