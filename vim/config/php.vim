" ------------------------------------------------------------------------------
" # PHP Settings and Helpers
" ------------------------------------------------------------------------------

" Stop arrow matching on indent
" See :help PHP_noArrowMatching
let g:PHP_noArrowMatching = 1

function! ConvertToArrowFunctionInPipeline()
  let s:starting_line = line('.')
  silent! norm $?->if(lciwfnf)ld$a =>Jdt f;xJxxf-ik
  while line('.') >= s:starting_line
    silent! s/^\s*$\n//
    norm k
  endwhile
  exec s:starting_line
endfunction
