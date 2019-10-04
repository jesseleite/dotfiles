" ------------------------------------------------------------------------------
" # Fugitive Settings
" ------------------------------------------------------------------------------

augroup disable_plugins_in_fugitive
  autocmd!
  autocmd Filetype fugitive DisableWhitespace
augroup END
