" ------------------------------------------------------------------------------
" # Fern Settings
" ------------------------------------------------------------------------------

let g:fern#disable_default_mappings=1

function! FernActionGithubOpen()
  exec "norm \<Plug>(fern-action-open)"
  Gbrowse
endfunction

augroup fern_local_mappings
  autocmd! *
  autocmd FileType fern call FernLocalMappings()
augroup END
