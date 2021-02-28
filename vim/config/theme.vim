" ------------------------------------------------------------------------------
" # Everything Cosmetic
" ------------------------------------------------------------------------------

" Overall colour scheme
colorscheme base16-monokai

" Airline colour scheme
let g:airline_theme = 'base16color'

" Customize vertical split character
set fillchars+=vert:\ ,

" Highlight 121st character on lines that exceed 120
call matchadd('ColorColumn', '\%121v', 100)

" Helper to fuzzy find highlights
command! -nargs=1 -complete=highlight FindHighlight
  \ exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi'

" Customize UI colors
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight Search ctermbg=blue ctermfg=white
highlight IncSearch ctermbg=red ctermfg=white
highlight link Searchlight Incsearch
highlight Sneak ctermbg=blue ctermfg=white
highlight Visual ctermbg=black
highlight SneakScope ctermbg=black ctermfg=white
highlight LineNr ctermbg=none
highlight CursorLineNR ctermbg=black ctermfg=black
highlight SignColumn ctermbg=none
highlight ColorColumn ctermbg=black
highlight SignifySignAdd ctermbg=none ctermfg=green
highlight SignifySignChange ctermbg=none ctermfg=yellow
highlight SignifySignDelete ctermbg=none ctermfg=red
highlight VertSplit ctermbg=none ctermfg=none
highlight StatusLine ctermfg=none ctermbg=none
highlight StatusLineNC ctermfg=none ctermbg=none
highlight CursorLine ctermbg=black ctermfg=none
highlight QuickFixLine ctermbg=black ctermfg=none
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEWarningSign ctermbg=none ctermfg=magenta
highlight Pmenu ctermfg=grey ctermbg=black
highlight PmenuSel ctermfg=white ctermbg=blue
highlight PmenuSbar ctermbg=black
highlight PmenuThumb ctermbg=white
highlight Folded ctermbg=black ctermfg=darkgrey
highlight FoldColumn ctermbg=none ctermfg=darkgrey
highlight clear DiffChange
highlight DiffText ctermbg=blue ctermfg=white
highlight DiffAdd ctermbg=green ctermfg=white
highlight DiffDelete ctermbg=red ctermfg=white

" Fzf colours
" Highlights: fzf
highlight FzfFg ctermfg=white
highlight FzfBg ctermbg=none
highlight FzfHl ctermfg=blue
highlight FzfFgCurrent ctermfg=white
highlight FzfBgCurrent ctermbg=black
highlight FzfHlCurrent ctermfg=blue
highlight FzfInfo ctermfg=darkgrey
highlight FzfBorder ctermfg=darkgrey
highlight FzfPrompt ctermfg=green
highlight FzfPointer ctermfg=red
highlight FzfMarker ctermfg=red
highlight FzfSpinner ctermfg=green
highlight FzfHeader ctermfg=green

" Coc colours
highlight CocFloating ctermbg=234

" Customize syntax colours
highlight Function ctermfg=white
highlight String ctermfg=blue
highlight Boolean ctermfg=magenta
highlight Number ctermfg=yellow
highlight phpInclude ctermfg=blue
highlight phpVarSelector ctermfg=white
highlight phpMethodsVar ctermfg=white
highlight phpType ctermfg=green
highlight phpKeyword ctermfg=magenta
highlight phpNullValue ctermfg=yellow
highlight phpComment ctermfg=darkgrey
highlight phpTodo ctermfg=darkgrey
highlight jsOperator ctermfg=white
