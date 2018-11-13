" ------------------------------------------------------------------------------
" # Register Vimrc Local Mappings
" ------------------------------------------------------------------------------

augroup vimrc_local_mappings
  autocmd!
  execute 'autocmd BufReadPost ' . join(g:vimrc_related_paths, ',') . ' call VimrcLocalMappings()'
augroup END


" ------------------------------------------------------------------------------
" # Navigation Commands
" ------------------------------------------------------------------------------

command! GoToRelatedVimrcConfig call GoToRelatedVimrcConfig()
command! GoToRelatedVimrcMappings call GoToRelatedVimrcMappings()

function! GoToRelatedVimrcConfig()
  let ref = s:get_ref_from_annotation()
  let path = VimrcPath(ref['type'] . '-config/' . ref['slug'] . '.vim')
  if filereadable(path)
    silent execute 'edit ' . path
  elseif ref['type'] == 'plugin'
    silent execute 'edit ' . VimrcPath('plugins.vim')
    call s:go_to_ref(ref)
  elseif ref['type'] == 'local'
    silent execute 'edit ' . VimrcPath('vimrc')
    call s:go_to_ref(ref)
  else
    echo 'Config not found.'
  endif
endfunction

function! GoToRelatedVimrcMappings()
  if expand('%:t') == 'plugins.vim'
    let ref = s:get_ref_from_annotation()
  else
    let ref = s:get_ref_for_current_config_file()
  endif
  silent execute 'edit ' VimrcPath('mappings.vim')
  call s:go_to_ref(ref)
endfunction

function! s:get_ref_from_annotation()
  let line = line('.')
  normal {
  let pattern = '" \(.*\): \(.*\)'
  call search(pattern, '', line + 3)
  let ref = matchlist(getline('.'), pattern)
  execute 'normal ' . line . 'G'
  if empty(ref)
    return {'type': 'n/a', 'slug': 'n/a'}
  endif
  return {'type': tolower(ref[1]), 'slug': ref[2]}
endfunction

function! s:get_ref_for_current_config_file()
  let ref = matchlist(expand('%:p:r'), '\([^/]*\)-config/\([^/]*\)$')
  return {'type': tolower(ref[1]), 'slug': ref[2]}
endfunction

function! s:build_annotation_for_ref(ref)
  return a:ref['type'] . ': ' . a:ref['slug']
endfunction

function! s:go_to_ref(ref)
  let current_ref = s:get_ref_from_annotation()
  if current_ref == a:ref
    return
  endif
  let found_ref = search(s:build_annotation_for_ref(a:ref) . '\c')
  if found_ref == 0
    echo 'Ref not found.'
  endif
endfunction


" ------------------------------------------------------------------------------
" # Plugin Commands
" ------------------------------------------------------------------------------

command! GoToPluginUrl call GoToPluginUrl()
command! YankPluginUrl call YankPluginUrl()
command! PastePluginFromClipboard call PastePluginFromClipboard()

function! GoToPluginUrl()
  call YankPluginUrl()
  call system('chrome-cli open ' . @+)
endfunction

function! YankPluginUrl()
  normal ^wyi'
  let @+ = 'https://www.github.com/' . @+
  return @+
endfunction

function! PastePluginFromClipboard()
  normal G
  call search("Plug \'.*\'", 'b')
  execute "normal oPlug " . substitute("'p'", 'p', s:get_installable_plugin_from_clipboard(), '')
endfunction

function! s:get_installable_plugin_from_clipboard()
  if match(@+, 'github.com') > -1
    return matchlist(@+, '\.com/\([^/]*/[^/]*\)')[1]
  elseif match(@+, 'Plug ') > -1
    return matchlist(@+, "'\\(.*\\)'")[1]
  endif
  return @+
endfunction
