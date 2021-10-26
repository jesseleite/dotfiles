" ------------------------------------------------------------------------------
" # Mappings
" ------------------------------------------------------------------------------

" Leader
let mapleader = ' '

" Esc / Ctrl-c
inoremap jk <Esc>
cnoremap jk <C-c>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Edit the alternate / previously edited file
nmap <Leader>6 <C-^>

" Clear search highlighting
nmap <silent> <Leader>jk :nohlsearch<CR>

" Quit
nmap <Leader>q :q<CR>

" Write
nmap <Leader>w :w<CR>
imap jw <Esc>:w<CR>

" Write and reload current tab in chrome
nmap <silent> <Leader>R :w<CR>:call system('chrome-cli reload')<CR>

" Open in finder
nmap <silent> <Leader><Leader>o :!open $PWD<CR><CR>

" Browse with valet open
nmap <silent> <Leader><Leader>b :!valet open<CR><CR>

" Open in github desktop
nmap <silent> <Leader><Leader>g :!github<CR><CR>

" Cycle through windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Mappings: maximizer
nnoremap <silent> <Leader>o :MaximizerToggle<CR>

" Make window only window
nnoremap <Leader>O <C-w>o

" Window management
" Mappings: winmode
nmap <Leader><Leader>w <Plug>WinModeResizeStart

" Vertical split
nmap <silent> <Leader>v :vsplit<CR>

" Close buffer
" Mappings: bbye
nmap <silent> <Leader>c :Bdelete<CR>

" Telescope fuzzy finders
" Mappings: telescope
nnoremap <Leader>f <Cmd>Telescope git_files<CR>
nnoremap <Leader>F <Cmd>Telescope find_files<CR>
nnoremap <Leader>E <Cmd>Telescope file_browser<CR>
nnoremap <Leader>b <Cmd>Telescope buffers sort_lastused=true<CR>
nnoremap <Leader>m <Cmd>Telescope git_status<CR>
nnoremap <Leader>h <Cmd>Telescope project_history<CR>
nnoremap <Leader>H <Cmd>Telescope oldfiles<CR>
nnoremap <Leader>/ <Cmd>Telescope live_grep_raw<CR>
nnoremap <Leader>s <Cmd>Telescope lsp_document_symbols<CR>
nnoremap <Leader>S <Cmd>Telescope lsp_dynamic_workspace_symbols<CR>
" nnoremap <Leader>r <Cmd>Telescope lsp_references<CR>
nnoremap <Leader>l <Cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>C <Cmd>Telescope commands<CR>
nnoremap <Leader>: <Cmd>Telescope command_history<CR>
nnoremap <Leader><Leader>v <Cmd>Telescope sourcery<CR>
nnoremap <Leader><Leader>d <Cmd>Telescope dotfiles<CR>
nnoremap <Leader><Leader>h <Cmd>Telescope help_tags<CR>
nnoremap <Leader><Leader>s <Cmd>Telescope filetypes<CR>
nnoremap <Leader><Leader>S <Cmd>Telescope ultisnips<CR>
nnoremap <Leader><Leader>t <Cmd>Telescope<CR>

" Ag search project
" Mappings: agriculture
nmap <Leader><Leader>/ <Plug>AgRawSearch
vmap <Leader>/ <Plug>AgRawVisualSelection
nmap <Leader>* <Plug>AgRawWordUnderCursor

" Mappings: harpoon
nnoremap <Leader>gh :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <Leader>ga :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>gr :lua require("harpoon.mark").rm_file()<CR>
nnoremap <leader>gx :lua require("harpoon.mark").clear_all()<CR>
nnoremap <Leader>gj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>gk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>gl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <Leader>g; :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <Leader>gu :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <Leader>gi :lua require("harpoon.term").gotoTerminal(2)<CR>

" Run tests
" Mappings: test
nmap <Leader>rt :w<CR>:TestToggleStrategy<CR>
nmap <Leader>rs :w<CR>:TestSuite<CR>
nmap <Leader>rf :w<CR>:TestFile<CR>
nmap <Leader>rl :w<CR>:TestLast<CR>
nmap <Leader>rn :w<CR>:TestNearest<CR>
nmap <Leader>rv :w<CR>:TestVisit<CR>

" Run terminal command in interactive shell
" Mappings: run-interactive
nmap <Leader><Leader>r :Run!<Space>
nmap <Leader><Leader>i :Run! in<Space>

" Git
" Mappings: fugitive
nmap <Leader>G :Gedit :<CR>

" Github
" Mappings: rhubarb
nmap <Leader><Leader>go :Gbrowse<CR>

" File system explorer
" Mappings: fern
nmap <Leader>e :FernReveal .<CR>
function! FernLocalMappings()
  nmap <buffer><nowait> l <Plug>(fern-action-expand)
  nmap <buffer><nowait> h <Plug>(fern-action-collapse)
  nmap <buffer><nowait> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer><nowait> b <Plug>(fern-action-leave)
  nmap <buffer><nowait> <CR> <Plug>(fern-action-open)
  nmap <buffer><nowait> v <Plug>(fern-action-open:rightest)<C-w><C-p>
  nmap <buffer><nowait> o <Plug>(fern-action-open:system)
  nmap <buffer><nowait> f <Plug>(fern-action-new-file)
  nmap <buffer><nowait> d <Plug>(fern-action-new-dir)
  nmap <buffer><nowait> <Tab> <Plug>(fern-action-mark:toggle)
  nmap <buffer><nowait> r <Plug>(fern-action-rename)
  nmap <buffer><nowait> c <Plug>(fern-action-copy)
  nmap <buffer><nowait> m <Plug>(fern-action-move)
  nmap <buffer><nowait> y <Plug>(fern-action-clipboard-copy)
  nmap <buffer><nowait> x <Plug>(fern-action-clipboard-move)
  nmap <buffer><nowait> p <Plug>(fern-action-clipboard-paste)
  nmap <buffer><nowait> D <Plug>(fern-action-trash)
  nmap <buffer><nowait> g? <Plug>(fern-action-help:all)
endfunction

" Undo history
" Mappings: undotree
nmap <Leader><Leader>u :UndotreeToggle<CR>

" Single character sneak
" Mappings: sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Toggle camel case motions
" Mappings: camel-case-motions
nmap <silent> <Leader><Leader>c :ToggleCamelCaseMotions<CR>

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

" Increment/decrement numbers holding shift-`+/-` keys instead of ctrl-`a/x`
nmap + <C-a>
nmap _ <C-x>
vmap + <C-a>
vmap _ <C-x>

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

" Break undo sequence on specific characters
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Quicker macro playback
" Mappings: macro
nnoremap Q @q<CR>
xnoremap Q :norm @q<CR>
xnoremap @ :<C-u>call PlaybackMacroOverVisualRange()<CR>

" Vertically align
" Mappings: easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Snippet
" Mappings: ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Generic LSP intelligence
" Mappings: lsp
nnoremap <silent> <Leader>ig <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>iv :vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>id <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>ir <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>ii <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>ie <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> K <Cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <Cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <Cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" PHP intelligence
" Mappings: phpactor
autocmd FileType php nnoremap <buffer> <Leader>p :call phpactor#ContextMenu()<CR>
autocmd FileType php nnoremap <buffer> <Leader>pi :call phpactor#UseAdd()<CR>
autocmd FileType php nnoremap <buffer> <Leader>pt :call phpactor#Transform()<CR>

" PHP docblock generation
" Mappings: pdv
autocmd FileType php nnoremap <buffer> <Leader>pd :call pdv#DocumentWithSnip()<CR>

" PHP Laravel specific mappings
" Mappings: laravel
autocmd FileType php nnoremap <buffer> <Leader>pr :call LaravelConvertToRealTimeFacade()<CR>
nnoremap <Leader>gt :edit tinkeray.php<CR>

" HTML and CSS abbreviation expansion
" Mappings: emmet
imap <C-e> <plug>(emmet-expand-abbr)
nmap ]e <plug>(emmet-move-next)
nmap [e <plug>(emmet-move-prev)

" Debugger
" Mappings: vdebug
nnoremap <Leader>B :Breakpoint<CR>
nnoremap <Leader>V :VdebugStart<CR>

" Toggle quickfix and location lists
" Mappings: togglelist
nnoremap <Leader><Leader>q :call ToggleQuickfixList()<CR>
nnoremap <Leader><Leader>l :call ToggleLocationList()<CR>

" Mappings: treesitter
nnoremap <Leader><Leader>s :TSHighlightCapturesUnderCursor<CR>

" Mappings: quickfix
function! QuickfixLocalMappings()
  nnoremap <buffer> <CR> <CR>
  nnoremap <buffer><nowait> t :call TelescopeQuickfix()<CR>
  nnoremap <buffer><nowait> p :call PreviewQuickfixItem()<CR>
  nnoremap <buffer> dd :call RemoveQuickfixItem()<CR>
endfunction

" Mappings: help
function! HelpLocalMappings()
  nnoremap <buffer> <CR> <C-]>
  nnoremap <buffer> <Esc> <C-t>
endfunction

" Mappings: sourcery
function! SourceryMappings()
  nmap <buffer> <leader>gp <Plug>SourceryGoToRelatedPluginDefinition
  nmap <buffer> <leader>gm <Plug>SourceryGoToRelatedMappings
  nmap <buffer> <leader>gc <Plug>SourceryGoToRelatedConfig
  nnoremap <buffer><nowait> <leader>pg <Cmd>GoToPluginGithubUrl<CR>
  nnoremap <buffer><nowait> <leader>py <Cmd>PlugYankGithubUrl<CR>
  nnoremap <buffer><nowait> <leader>pl <Cmd>UseLocalPluginRepo<CR>
  nnoremap <buffer><nowait> <leader>pp <Cmd>PlugPasteFromClipboard<CR>
  nnoremap <buffer><nowait> <leader>pi <Cmd>PlugInstall<CR>
  nnoremap <buffer><nowait> <leader>pu <Cmd>PlugUpdate<CR>
  nnoremap <buffer><nowait> <leader>pc <Cmd>PlugClean<CR>
endfunction
