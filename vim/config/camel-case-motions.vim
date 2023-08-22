" ------------------------------------------------------------------------------
" # Camel Case Motions
" ------------------------------------------------------------------------------

let s:camel_case_motions = 0
let s:starting_line = 0

function! ToggleCamelCaseMotions()
  if s:camel_case_motions
    unmap <silent> w
    unmap <silent> b
    unmap <silent> e
    unmap <silent> ge
    ounmap <silent> iw
    xunmap <silent> iw
    ounmap <silent> ib
    xunmap <silent> ib
    ounmap <silent> ie
    xunmap <silent> ie
    let s:camel_case_motions = 0
    let s:starting_line = 0
    echo 'Camel case motions disabled'
  else
    map <silent> w <Plug>CamelCaseMotion_w
    map <silent> b <Plug>CamelCaseMotion_b
    map <silent> e <Plug>CamelCaseMotion_e
    map <silent> ge <Plug>CamelCaseMotion_ge
    omap <silent> iw <Plug>CamelCaseMotion_iw
    xmap <silent> iw <Plug>CamelCaseMotion_iw
    omap <silent> ib <Plug>CamelCaseMotion_ib
    xmap <silent> ib <Plug>CamelCaseMotion_ib
    omap <silent> ie <Plug>CamelCaseMotion_ie
    xmap <silent> ie <Plug>CamelCaseMotion_ie
    let s:camel_case_motions = 1
    let s:starting_line = line('.')
    echo 'Camel case motions enabled'
  end
endfunction

function! ResetCamelCaseMotions()
  if s:camel_case_motions && s:starting_line != line('.')
    call ToggleCamelCaseMotions()
  end
endfunction

command! ToggleCamelCaseMotions call ToggleCamelCaseMotions()
command! ResetCamelCaseMotions call ResetCamelCaseMotions()

augroup toggle_camel_case_motions
  autocmd!
  autocmd CursorHold,CursorHoldI * ResetCamelCaseMotions
augroup end
