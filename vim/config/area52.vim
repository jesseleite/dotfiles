" ------------------------------------------------------------------------------
" # Experimental Stuff
" ------------------------------------------------------------------------------
" # This is where I put stuff that I'm either testing or embarassed
" # about. No shame; Just aliens, UFOs, and cows, and experiments.

function! ClearRegisters()
  let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
  let i=0
  while (i<strlen(regs))
      exec 'let @'.regs[i].'=""'
      let i=i+1
  endwhile
endfunction

nnoremap <silent> <Leader><Leader>p :args *<CR>
nnoremap <silent> <Leader><Leader>j :bnext<CR>
nnoremap <silent> <Leader><Leader>k :bprev<CR>

" Visual paste without losing what is in register
" This mapping doesn't work because vim-pasta hijacks it
" Keep an eye on this... https://github.com/sickill/vim-pasta/pull/18
" vnoremap p "0p
vnoremap <leader>p "0p

" Config: copilot
" let g:copilot_no_tab_map = v:true
" imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")

" Yank and delete {} objects (can I just do this with custom treesitter text objects though?)
nmap YO va{Vy
nmap DO va{Vd

" Mess with artisan make from Timmy Mac...
function! ArtisanMake(input)
  let l:before = system('php -r "echo hrtime(true);"')
  let l:output = system('php artisan make:'.a:input)


  if v:shell_error != 0
    return v:shell_error
  endif

  let l:within = l:after - l:before
  let l:path = trim(system('fd --changed-within="'.l:within.' ns" --type f'))

  execute('e '.l:path)
endfunction

" Run on selection of lines to prepare Statamic changelog...
function! Changelog()
  norm ^dwi- f(f#hhi.llr[llyiwf)r]a(http://github.com/statamic/cms/issues/pA by @
endfunction

" Close current antlers tag pair...
function! CloseAntlersPair()
  silent! s/\([^ ]\)}}/\1 }}/
  norm $F{w"ayt A
  let @a = '{{ /' . @a . ' }}'
  exec 'norm $"ap==kA
  startinsert!
endfunction

" Good advice from Malko
function! Honey()
  echo "Stay hydrated. Eat local honey. Use vim."
endfunction

command! Honey call Honey()


" ------------------------------------------------------------------------------
" # Debug mappings...
" ------------------------------------------------------------------------------

function! Maps(search, leader)
  let search = a:leader ? '<Leader>' . a:search : a:search
  execute 'verbose map' search
endfunction

command! -bang -nargs=1 Maps call Maps(<q-args>, <bang>0)


" ------------------------------------------------------------------------------
" # Recursively create missing directories when saving new file...
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