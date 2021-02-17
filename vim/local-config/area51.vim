" ------------------------------------------------------------------------------
" # Experimental Stuff
" ------------------------------------------------------------------------------

" Strip whitespace on save
augroup misc_commands
  autocmd!
  autocmd BufEnter * EnableStripWhitespaceOnSave
augroup END

function! RecordGif()
  let g:fzf_layout = { 'down': '~55%' }
  :ALEDisable
endfunction
command! RecordGif silent! call RecordGif()

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

function! OpenWritableSearchBufferFromQuickfix()
  WritableSearchFromQuickfix
  wincmd o
endfunction
command! OpenWritableSearchBufferFromQuickfix silent! call OpenWritableSearchBufferFromQuickfix()


" Because :sav works, but doesn't save relative to the source's location, and doesn't open the duplicated file either.

function! DuplicateCurrentFile(path)
  let path = "%:h/" . a:path
  execute "saveas " . path
  execute "edit " . path
endfunction

command! -nargs=1 Duplicate call DuplicateCurrentFile(<q-args>)

" Php import sorting.
" Look into php-cs-fixer and ale instead? :P

function! SortLinesByLength() range
  silent execute a:firstline . ',' . a:lastline . 'sort'
  silent execute a:firstline . ',' . a:lastline . 's/^\(.*\)$/\=strdisplaywidth(submatch(0))." ".submatch(0)/'
  silent execute a:firstline . ',' . a:lastline . 'sort n'
  silent execute a:firstline . ',' . a:lastline . 's/^\d\+\s//'
endfunction

function! PhpSortImports(...)
  normal gg
  call search('use .*;')
  let firstline = line('.')
  if firstline == 1
    echo 'No imports to sort.'
    return
  endif
  normal }k
  let lastline = line('.')
  if a:0 && a:1 == 'length'
    execute firstline . ',' . lastline . 'call SortLinesByLength()'
    echo 'Sorted imports by length.'
  else
    execute firstline . ',' . lastline . 'sort'
    echo 'Sorted imports alphabetically.'
  endif
endfunction

command! -bar PhpSortImports call PhpSortImports()
command! -bar PhpSortImportsByLength call PhpSortImports('length')

nmap <Leader>psi :PhpSortImports<CR>
nmap <Leader>psl :PhpSortImportsByLength<CR>

" Stop arrow matching on indent
" See: /usr/local/share/vim/vim81/indent/php.vim
let g:PHP_noArrowMatching = 1

" Messing with CtrlSF

let g:ctrlsf_ackprg = '/usr/local/bin/ag'

let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

command! -n=* -comp=customlist,ctrlsf#comp#Completion CtrlSFSmart call ctrlsf#Search(agriculture#smart_quote_input(<q-args>))

nmap <Leader><Leader><Leader>/ :CtrlSFSmart<Space>

" Not sure I actually want this
" let g:user_emmet_settings = {
" \  'html' : {
" \    'indent_blockelement': 1,
" \  },
" \}

" autocmd FileType vim nnoremap <buffer> <leader>s :source %<CR>

function! ResourceAndRunLast()
  silent source /Users/jesseleite/Code/vim-sourcery/autoload/sourcery.vim
  execute @:
endfunction

nmap <Leader>s :call ResourceAndRunLast()<CR>
