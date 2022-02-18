" ------------------------------------------------------------------------------
" # Filetype Settings
" ------------------------------------------------------------------------------

augroup filetype_settings
  autocmd!
  autocmd FileType zsh setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType vim setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType lua setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s iskeyword+=$
  autocmd FileType html setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType css setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType scss setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType less setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType javascript setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType json setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType vue setlocal ts=4 sw=4 sts=4 expandtab commentstring=//\ %s
  autocmd FileType vue syntax sync fromstart
  autocmd FileType snippets setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType markdown setlocal wrap
  autocmd FileType c setlocal ts=2 sw=2 sts=2 expandtab commentstring=//\ %s iskeyword+=$
augroup END

augroup framework_filetype_settings
  autocmd!
  autocmd BufRead,BufNewFile *.blade.php setlocal commentstring={{--\ %s\ --}} filetype=blade
  autocmd BufRead,BufNewFile *.antlers.html setlocal commentstring={{#\ %s\ #}} filetype=html
augroup END
