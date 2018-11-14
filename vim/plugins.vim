" ------------------------------------------------------------------------------
" # Installed Plugins
" ------------------------------------------------------------------------------

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
Plug 'milkypostman/vim-togglelist'      " Quickfix/Location toggler
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
Plug 'christoomey/vim-run-interactive'  " Run terminal commands in interactive shell
Plug 'houtsnip/vim-emacscommandline'    " Emacs style mappings for ex commands
Plug 'wellle/targets.vim'               " Additional text objects, and better seeking
Plug 'justinmk/vim-sneak'               " Sneak motion and better f/t motions
Plug 'AndrewRadev/writable_search.vim'  " Writable search buffer from quickfix

" Explicit annotation bindings for more accurate go to
let g:explicit_annotation_bindings = {
  \ 'fzf': 'fzf.vim',
  \ 'writable-search': 'writable_search.vim',
  \ }


" ------------------------------------------------------------------------------
" # Basic Plugin Configuration
" ------------------------------------------------------------------------------
" # This is for basic plugin config only.  More elaborate plugin config
" # files are located in the /plugin-config folder.

" Plugin: bufkill
let g:BufKillCreateMappings = 0

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
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB'

" Plugin: writable-search
let g:writable_search_new_buffer_command = 'enew'
