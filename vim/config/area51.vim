" ------------------------------------------------------------------------------
" # Experimental Stuff
" ------------------------------------------------------------------------------
" # This is where I put stuff that I'm either testing or embarassed
" # about. No shame; Just aliens, UFOs, and cows, and experiments.


" Visual paste without losing what is in register
" Which isn't working because of vim-pasta?
" vnoremap <Leader>p "_dP


" ------------------------------------------------------------------------------
" # Debug mappings...
" ------------------------------------------------------------------------------

function! Maps(search, leader)
  let search = a:leader ? '<Leader>' . a:search : a:search
  execute 'verbose map' search
endfunction

command! -bang -nargs=1 Maps call Maps(<q-args>, <bang>0)


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
" # Duplicate current file...
" ------------------------------------------------------------------------------

function! DuplicateCurrentFile(path)
  let path = "%:h/" . a:path
  execute "saveas " . path
  execute "edit " . path
endfunction

command! -nargs=1 Duplicate call DuplicateCurrentFile(<q-args>)


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
