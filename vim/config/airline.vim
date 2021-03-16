" ------------------------------------------------------------------------------
" # Airline Settings
" ------------------------------------------------------------------------------

let g:airline_theme = 'base16color'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = '⎇'

call airline#parts#define_accent('mode', 'none')
