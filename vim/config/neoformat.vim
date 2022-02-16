" ------------------------------------------------------------------------------
" # Neoformat Config
" ------------------------------------------------------------------------------

let g:neoformat_html_antlersformat = {
  \ 'exe': 'antlersformat',
  \ 'args': ['format', '--o', '~/.dotfiles/statamic/antlersformat.json'],
  \ 'replace': 1,
  \ }

let g:neoformat_enabled_php = ['phpcsfixer']

let g:neoformat_enabled_html = ['antlersformat']


" ------------------------------------------------------------------------------
" # Toggle Neoformat
" ------------------------------------------------------------------------------

let s:neoformat_enabled = 1

function! RunNeoformat()
  if s:neoformat_enabled
    Neoformat
  endif
endfunction

function! ToggleNeoformat()
  if s:neoformat_enabled
    let s:neoformat_enabled = 0
    echo 'Neoformat disabled'
  else
    let s:neoformat_enabled = 1
    echo 'Neoformat enabled'
  endif
endfunction


" ------------------------------------------------------------------------------
" # Register Neoformat On Save
" ------------------------------------------------------------------------------

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *.php call RunNeoformat()
  autocmd BufWritePre *.antlers.html call RunNeoformat()
augroup END
