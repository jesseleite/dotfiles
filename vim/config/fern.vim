" ------------------------------------------------------------------------------
" # Fern Settings
" ------------------------------------------------------------------------------

let g:fern#disable_default_mappings = 1

augroup fern_local_mappings
  autocmd! *
  autocmd FileType fern call FernLocalMappings()
augroup END

function! FernReveal(location)
  let current_file = match(@%, '/') == 0 ? @% : getcwd() . '/' . @%
  if empty(@%)
    exec 'Fern ' . a:location
  elseif filereadable(current_file)
    exec 'Fern ' . a:location . ' -reveal=%'
  else
    exec 'Fern ' . substitute(@%, '/'. expand('%:t'), '', '') . ' -reveal=%'
  endif
endfunction

command! -nargs=* FernReveal call FernReveal(<f-args>)
