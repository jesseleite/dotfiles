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
  let file = @%
  if empty(file)
    exec 'Fern ' . a:location
  else
    exec 'Fern ' . a:location . ' -reveal=%'
  endif
endfunction

command! -nargs=* FernReveal call FernReveal(<f-args>)
