" ------------------------------------------------------------------------------
" # Neoformat Config
" ------------------------------------------------------------------------------

let g:neoformat_enabled_php = ['phpcsfixer']
let g:neoformat_enabled_json = ['fixjson']
let g:neoformat_enabled_html = ['antlersformat']

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *.php call RunNeoformat()
  autocmd BufWritePre *.json call RunNeoformat()
  autocmd BufWritePre *.antlers.html call RunNeoformat()
augroup END


" ------------------------------------------------------------------------------
" # Custom Formatters
" ------------------------------------------------------------------------------

let g:neoformat_html_antlersformat = {
  \ 'exe': 'antlersformat',
  \ 'args': ['format'],
  \ 'replace': 1,
  \ }


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
