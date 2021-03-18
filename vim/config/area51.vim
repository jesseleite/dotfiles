" ------------------------------------------------------------------------------
" # Experimental Stuff
" ------------------------------------------------------------------------------

function! Maps(search, leader)
  let search = a:leader ? '<Leader>' . a:search : a:search
  execute 'verbose map' search
endfunction

command! -bang -nargs=1 Maps call Maps(<q-args>, <bang>0)

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

" ------------------------------------------------------------------------------
" # Reload and execution helpers for easier plugin dev...
" ------------------------------------------------------------------------------

lua reload_module = require('plenary.reload').reload_module

function! ExecuteLine()
  if &ft == 'lua'
    call execute(printf(":lua %s", getline(".")))
  elseif &ft == 'vim'
    exe getline(">")
  endif
endfunction

function! ExecuteFile()
  if &filetype == 'vim'
    silent! write
    source %
  elseif &filetype == 'lua'
    silent! write
    luafile %
  endif
endfunction

nnoremap <leader>x :call ExecuteFile()<CR>
nnoremap <leader><leader>x :call ExecuteLine()<CR>
nnoremap <leader><leader>c :<up><CR>
