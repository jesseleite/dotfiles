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

" Cycle through windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Make window only window
nnoremap <Leader>o <C-w>o

" Resize window
" Plugin: winmode
nmap <Leader><Leader>w <Plug>WinModeResizeStart

" Close buffer, and disable intrusive BuffKill mappings
" Plugin: bufkill
nmap <silent> <Leader>c :BD<CR>

" Next/prev git change, and disable intrusive GitGutter mappings
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" Fzf fuzzy finders
" Plugin: fzf
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
" nmap <Leader>m :Methods<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>h :History<CR>
" nmap <Leader>H :GHistory<CR>
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
nmap <Leader><Leader>p :Run! in project<Space>
nmap <Leader><Leader>a :Run! art<Space>

" Git
" Plugin: fugitive
nmap <Leader><Leader>gst :Gstatus<CR><Space>o
nmap <Leader><Leader>gc :Gcommit<CR><Space>o
nmap <Leader><Leader>gbl :Gblame<CR>

" Github
" Plugin: rhubarb
nmap <Leader><Leader>gbr :Gbrowse<CR>

" File system browser
" Plugin: nerdtree
nmap <Leader><Tab> :NERDTreeToggle<CR>
nmap <Leader><Leader><Tab> :NERDTree<CR>
nmap <Leader><Leader><Tab>f :NERDTreeFind<CR>zz

" Tag browser
" Plugin: tagbar
nmap <Leader>\ :TagbarToggle<CR>

" Undo history
" Plugin: undotree
nmap <Leader><Leader>u :UndotreeToggle<CR>

" Single character sneak
" Plugin: sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

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

" Plugin: Phpactor
nnoremap <Leader>p :call phpactor#ContextMenu()<CR>
nnoremap <Leader>pg :call phpactor#GotoDefinition()<CR>
nnoremap <Leader>pi :call phpactor#UseAdd()<CR>
nnoremap <Leader>pt :call phpactor#Transform()<CR>

" PHP docblocks
" Plugin: pdv
nnoremap <Leader>D :call pdv#DocumentWithSnip()<CR>

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
