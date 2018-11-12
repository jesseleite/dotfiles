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
nmap <Leader><Leader>r :Run!<Space>
nmap <Leader><Leader>i :Run! in<Space>
nmap <Leader><Leader>p :Run! in project<Space>
nmap <Leader><Leader>a :Run! art<Space>

" Git / Github
nmap <Leader><Leader>gst :Gstatus<CR><Space>o
nmap <Leader><Leader>gc :Gcommit<CR><Space>o
nmap <Leader><Leader>gbr :Gbrowse<CR>
nmap <Leader><Leader>gbl :Gblame<CR>

" Panel toggles
nmap <Leader><Tab> :NERDTreeToggle<CR>
nmap <Leader><Leader><Tab> :NERDTree<CR>
nmap <Leader><Leader><Tab>f :NERDTreeFind<CR>zz
nmap <Leader>\ :TagbarToggle<CR>
nmap <Leader><Leader>u :UndotreeToggle<CR>
let g:lt_quickfix_list_toggle_map = '<Leader><Leader>q'

" Quickfix
" Local: quickfix
let g:lt_location_list_toggle_map = '<Leader><Leader>l'

" Single character sneak
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
