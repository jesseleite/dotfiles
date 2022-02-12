" ------------------------------------------------------------------------------
" # Neoformat Config
" ------------------------------------------------------------------------------

let g:neoformat_html_antlersformat = {
  \ 'exe': 'antlersformat',
  \ 'args': ['format', '"%"', '--o', '~/.dotfiles/statamic/antlersformat.json', '--output'],
  \ 'replace': 1,
  \ }

let g:neoformat_enabled_php = ['phpcsfixer']

let g:neoformat_enabled_html = ['antlersformat']

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *.php Neoformat
  autocmd BufWritePre *.antlers.html Neoformat
augroup END
