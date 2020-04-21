" ------------------------------------------------------------------------------
" # Fzf Settings
" ------------------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }
let g:fzf_preview_window = ''

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'String'],
  \ 'fg+':     ['fg', 'Operator', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'String'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Function'],
  \ 'pointer': ['fg', 'Statement'],
  \ 'marker':  ['fg', 'Conditional'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! Mapsn call fzf#vim#maps('n', 0)
command! Mapsx call fzf#vim#maps('x', 0)
command! Mapso call fzf#vim#maps('o', 0)
command! Mapsi call fzf#vim#maps('i', 0)
command! Mapsv call fzf#vim#maps('v', 0)
command! Mapsa call fzf#vim#maps('a', 0)

command! -bang MFiles call fzf#run(fzf#wrap({
  \ 'source': 'git status --short | sed s/^...//',
  \ 'options': [
  \   '--prompt', 'ModifiedFiles> ',
  \   '--multi',
  \   '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \ ]}, <bang>0))
