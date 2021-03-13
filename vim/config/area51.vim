" ------------------------------------------------------------------------------
" # Experimental Stuff
" ------------------------------------------------------------------------------

if exists('*EnableStripWhitespaceOnSave')
  augroup misc_commands
    autocmd!
    autocmd BufEnter * EnableStripWhitespaceOnSave
  augroup END
endif

function! DuplicateCurrentFile(path)
  let path = "%:h/" . a:path
  execute "saveas " . path
  execute "edit " . path
endfunction

command! -nargs=1 Duplicate call DuplicateCurrentFile(<q-args>)

" Stop arrow matching on indent
" See: /usr/local/share/vim/vim81/indent/php.vim
let g:PHP_noArrowMatching = 1

" Not sure I actually want this
" let g:user_emmet_settings = {
" \  'html' : {
" \    'indent_blockelement': 1,
" \  },
" \}

" ------------------------------------------------------------------------------
" # Recursively missing directories when saving new file...
" ------------------------------------------------------------------------------

function s:create_missing_directories(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup create_missing_directories
  autocmd!
  autocmd BufWritePre * :call s:create_missing_directories(expand('<afile>'), +expand('<abuf>'))
augroup END
