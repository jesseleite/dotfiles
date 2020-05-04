" ------------------------------------------------------------------------------
" # Fern Settings
" ------------------------------------------------------------------------------

let g:fern#disable_default_mappings = 1

augroup fern_local_mappings
  autocmd! *
  autocmd FileType fern call FernLocalMappings()
augroup END

function! FernActionGithubOpen()
  exec "norm \<Plug>(fern-action-open)"
  Gbrowse
endfunction

function! FernReveal(location)
  if empty(@%)
    exec 'Fern ' . a:location
  elseif filereadable(getcwd() . '/' . @%)
    exec 'Fern ' . a:location . ' -reveal=%'
  else
    exec 'Fern ' . substitute(@%, '/'. expand('%:t'), '', '') . ' -reveal=%'
  endif
endfunction

command! -nargs=* FernReveal call FernReveal(<f-args>)
