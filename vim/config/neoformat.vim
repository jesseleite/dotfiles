" ------------------------------------------------------------------------------
" # Neoformat Config
" ------------------------------------------------------------------------------

let g:neoformat_enabled_php = ['phpcsfixer']

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *.php Neoformat
augroup END
