" ------------------------------------------------------------------------------
" # Mappings
" ------------------------------------------------------------------------------

" Leader
let mapleader = "\<Space>"

" Esc / Ctrl-c
imap jk <Esc>
cnoremap jk <C-c>

" Edit the alternate / previously edited file
nmap <Leader>6 <C-^>

" Clear search highlighting
nmap <silent> <Leader>jk :nohlsearch<CR>

" Quit
nmap <Leader>q :q<CR>

" Write
nmap <Leader>w :w<CR>
imap jw <Esc>:w<CR>
map <D-s> <Esc>:w<CR>
map <M-s> <Esc>:w<CR>
map <C-s> <Esc>:w<CR>

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

" Plugin: maximizer
nnoremap <silent> <Leader>o :MaximizerToggle<CR>

" Make window only window
nnoremap <Leader>O <C-w>o

" Window management
" Plugin: winmode
nmap <Leader><Leader>w <Plug>WinModeResizeStart

" Vertical split
nmap <silent> <Leader>v :vsplit<CR>

" Close buffer
" Plugin: bbye
nmap <silent> <Leader>c :Bdelete<CR>

" Next/prev git change, and disable intrusive GitGutter mappings
let g:gitgutter_map_keys = 0
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" Fzf fuzzy finders
" Plugin: fzf
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>m :GFiles?<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>h :PHistory<CR>
nmap <Leader>H :History<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>M :Maps<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>s :Filetypes<CR>
nmap <Leader>S :Snippets<CR>
nmap <Leader><Leader>h :Helptags!<CR>

" Ag search project
" Plugin: agriculture
nmap <Leader>/ <Plug>AgRawSearch
vmap <Leader>/ <Plug>AgRawVisualSelection
nmap <Leader>* <Plug>AgRawWordUnderCursor

" Run tests
" Plugin: test
nmap <Leader>rt :w<CR>:TestToggleStrategy<CR>
nmap <Leader>rs :w<CR>:TestSuite<CR>
nmap <Leader>rf :w<CR>:TestFile<CR>
nmap <Leader>rl :w<CR>:TestLast<CR>
nmap <Leader>rn :w<CR>:TestNearest<CR>
nmap <Leader>rv :w<CR>:TestVisit<CR>

" Run terminal command in interactive shell
" Plugin: run-interactive
nmap <Leader><Leader>r :Run!<Space>
nmap <Leader><Leader>i :Run! in<Space>

" Git
" Plugin: fugitive
nmap <Leader>g :Gedit :<CR>
nmap <Leader><Leader>gp :Gpush<CR>
nmap <Leader><Leader>gb :Gblame<CR>

" Github
" Plugin: rhubarb
nmap <Leader><Leader>go :Gbrowse<CR>

" File system explorer
" Plugin: fern
nmap <Leader>e :FernReveal .<CR>
nmap <Leader>E :Fern .<CR>
function! FernLocalMappings()
  nmap <buffer><nowait> l <Plug>(fern-action-expand)
  nmap <buffer><nowait> h <Plug>(fern-action-collapse)
  nmap <buffer><nowait> s <Plug>(fern-action-hidden-toggle)
  nmap <buffer><nowait> b <Plug>(fern-action-leave)
  nmap <buffer><nowait> <CR> <Plug>(fern-action-open)
  nmap <buffer><nowait> v <Plug>(fern-action-open:rightest)<C-w><C-p>
  nmap <buffer><nowait> o <Plug>(fern-action-open:system)
  nmap <buffer><nowait> f <Plug>(fern-action-new-file)
  nmap <buffer><nowait> d <Plug>(fern-action-new-dir)
  nmap <buffer><nowait> - <Plug>(fern-action-mark-toggle)
  nmap <buffer><nowait> r <Plug>(fern-action-rename)
  nmap <buffer><nowait> c <Plug>(fern-action-copy)
  nmap <buffer><nowait> m <Plug>(fern-action-move)
  nmap <buffer><nowait> y <Plug>(fern-action-clipboard-copy)
  nmap <buffer><nowait> x <Plug>(fern-action-clipboard-move)
  nmap <buffer><nowait> p <Plug>(fern-action-clipboard-paste)
  nmap <buffer><nowait> D <Plug>(fern-action-trash)
  nmap <buffer><nowait> go :call FernActionGithubOpen()<CR>
  nmap <buffer><nowait> g? <Plug>(fern-action-help:all)
endfunction

" Undo history
" Plugin: undotree
nmap <Leader><Leader>u :UndotreeToggle<CR>

" Single character sneak
" Plugin: sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Toggle camel case motions
" Plugin: camel-case-motions
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
" Local: macro
nnoremap Q @q<CR>
xnoremap Q :norm @q<CR>
xnoremap @ :<C-u>call PlaybackMacroOverVisualRange()<CR>

" Vertically align
" Plugin: easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Snippet
" Plugin: ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Ale
" Plugin: ale
nnoremap <Leader><Leader>a :ALEToggle<CR>
nnoremap <Leader>if :ALEFix<CR>

" Generic LSP intelligence
" Plugin: coc
nmap <silent> <Leader>ig <Plug>(coc-definition)
nmap <silent> <Leader>iv :vsplit<CR><Plug>(coc-definition)
nmap <silent> <Leader>it <Plug>(coc-type-definition)
inoremap <silent><expr> <C-l> coc#refresh()

" PHP intelligence
" Plugin: phpactor
autocmd FileType php nnoremap <buffer> <Leader>p :call phpactor#ContextMenu()<CR>
autocmd FileType php nnoremap <buffer> <Leader>pi :call phpactor#UseAdd()<CR>
autocmd FileType php nnoremap <buffer> <Leader>pt :call phpactor#Transform()<CR>

" PHP docblock generation
" Plugin: pdv
autocmd FileType php nnoremap <buffer> <Leader>pd :call pdv#DocumentWithSnip()<CR>

" HTML and CSS abbreviation expansion
" Plugin: emmet
imap <C-e> <plug>(emmet-expand-abbr)
nmap ]e <plug>(emmet-move-next)
nmap [e <plug>(emmet-move-prev)

" Debugger
" Plugin: vdebug
nnoremap <Leader>B :Breakpoint<CR>
nnoremap <Leader>V :VdebugStart<CR>

" Toggle quickfix and location lists
" Plugin: togglelist
nnoremap <Leader><Leader>q :call ToggleQuickfixList()<CR>
nnoremap <Leader><Leader>l :call ToggleLocationList()<CR>

" Local: quickfix
function! QuickfixLocalMappings()
  nnoremap <buffer> <CR> <CR>
  nnoremap <buffer><nowait> p :PreviewQuickfixItem<CR>
  nnoremap <buffer> dd :RemoveQuickfixItem<CR>
  nnoremap <buffer> <Leader>w :OpenWritableSearchBufferFromQuickfix<CR>
endfunction

" Local: help
function! HelpLocalMappings()
  nnoremap <buffer> <CR> <C-]>
  nnoremap <buffer> <Esc> <C-t>
endfunction

" Local: vimrc
nmap <Leader><Leader>v :EditVimrc<CR>
nmap <Leader><Leader>vm :EditVimMappings<CR>
nmap <Leader><Leader>vp :EditVimPlugins<CR>
function! VimrcLocalMappings()
  nnoremap <buffer><nowait> <leader>gc :GoToRelatedVimrcConfig<CR>
  nnoremap <buffer><nowait> <leader>gm :GoToRelatedVimrcMappings<CR>
  nnoremap <buffer><nowait> <leader>gp :GoToRelatedPlugDefinition<CR>
  nnoremap <buffer><nowait> <leader>pg :GoToPluginUrl<CR>
  nnoremap <buffer><nowait> <leader>py :YankPluginUrl<CR>
  nnoremap <buffer><nowait> <leader>pp :PastePluginFromClipboard<CR>
  nnoremap <buffer><nowait> <leader>pi :PlugInstall<CR>
  nnoremap <buffer><nowait> <leader>pu :PlugUpdate<CR>
  nnoremap <buffer><nowait> <leader>pc :PlugClean<CR>
endfunction
