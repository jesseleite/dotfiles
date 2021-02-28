" ------------------------------------------------------------------------------
" # Fzf Settings
" ------------------------------------------------------------------------------

let g:fzf_history_dir = '~/.vim/fzf_history'


" ------------------------------------------------------------------------------
" # Theming
" ------------------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'border': 'sharp' } }
let g:fzf_preview_window = 'right:50%:noborder:hidden'

" TODO: Convert these to fzf highlight groups (ie. FzfPrompt)
" let g:fzf_colors = {
"   \ 'fg':      ['fg', 'FzfFg'],
"   \ 'bg':      ['bg', 'FzfBg'],
"   \ 'hl':      ['fg', 'FzfHl'],
"   \ 'fg+':     ['fg', 'FzfFgCurrent'],
"   \ 'bg+':     ['bg', 'FzfBgCurrent'],
"   \ 'hl+':     ['fg', 'FzfHlCurrent'],
"   \ 'info':    ['fg', 'FzfInfo'],
"   \ 'border':  ['fg', 'FzfBorder'],
"   \ 'prompt':  ['fg', 'FzfPrompt'],
"   \ 'pointer': ['fg', 'FzfPointer'],
"   \ 'marker':  ['fg', 'FzfMarker'],
"   \ 'spinner': ['fg', 'FzfSpinner'],
"   \ 'header':  ['fg', 'FzfHeader'] }


" ------------------------------------------------------------------------------
" # Mappings Finders
" ------------------------------------------------------------------------------

command! Mapsn call fzf#vim#maps('n', 0)
command! Mapsx call fzf#vim#maps('x', 0)
command! Mapso call fzf#vim#maps('o', 0)
command! Mapsi call fzf#vim#maps('i', 0)
command! Mapsv call fzf#vim#maps('v', 0)
command! Mapsa call fzf#vim#maps('a', 0)


" ------------------------------------------------------------------------------
" # Scoped History Finders
" ------------------------------------------------------------------------------

command! -bang PHistory call fzf#run(fzf#wrap(s:preview(<bang>0, {
  \ 'source': s:file_history_from_directory(s:get_git_root()),
  \ 'options': [
  \   '--prompt', 'ProjectHistory> ',
  \   '--multi',
  \ ]}), <bang>0))

command! -bang CwdHistory call fzf#run(fzf#wrap(s:preview(<bang>0, {
  \ 'source': s:file_history_from_directory(getcwd()),
  \ 'options': [
  \   '--prompt', 'CwdHistory> ',
  \   '--multi',
  \ ]}), <bang>0))

function! s:file_history_from_directory(directory)
  return fzf#vim#_uniq(filter(fzf#vim#_recent_files(), "s:file_is_in_directory(fnamemodify(v:val, ':p'), a:directory)"))
endfunction

function! s:file_is_in_directory(file, directory)
  return filereadable(a:file) && match(a:file, a:directory . '/') == 0
endfunction


" ------------------------------------------------------------------------------
" # Script functions copied from fzf.vim to make above things work
" ------------------------------------------------------------------------------

function! s:preview(bang, ...)
  let preview_window = get(g:, 'fzf_preview_window', a:bang && &columns >= 80 || &columns >= 120 ? 'right': '')
  if len(preview_window)
    return call('fzf#vim#with_preview', add(copy(a:000), preview_window))
  endif
  return {}
endfunction

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction
