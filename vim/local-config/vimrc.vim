" ------------------------------------------------------------------------------
" # Register Vimrc Local Mappings
" ------------------------------------------------------------------------------

augroup vimrc_local_mappings
  autocmd!
  execute 'autocmd BufReadPost ' . join(sourcery#autosource_paths, ',') . ' call VimrcLocalMappings()'
augroup END


" ------------------------------------------------------------------------------
" # Basic Edit Commands
" ------------------------------------------------------------------------------

command! EditVimrc call EditVimConfig('vimrc')
command! EditVimMappings call EditVimConfig('mappings.vim')
command! EditVimPlugins call EditVimConfig('plugins.vim')

function! EditVimConfig(file)
  execute 'edit ' . sourcery#vimrc_path(a:file)
endfunction


" ------------------------------------------------------------------------------
" # Smart Navigation Commands
" ------------------------------------------------------------------------------

command! GoToRelatedVimrcConfig call GoToRelatedVimrcConfig()
command! GoToRelatedVimrcMappings call GoToRelatedVimrcMappings()
command! GoToRelatedPlugDefinition call GoToRelatedPlugDefinition()

function! GoToRelatedVimrcConfig()
  if match(getline('.'), "Plug '") == -1 && (expand('%:t') == 'plugins.vim' || match(expand('%:h:t'), 'config') > 0)
    echo 'Already in config.'
    return
  endif
  let ref = s:get_ref()
  let path = sourcery#vimrc_path(ref['type'] . '-config/' . ref['slug'] . '.vim')
  if filereadable(path)
    silent execute 'edit ' . path
  elseif ref['type'] == 'plugin'
    silent execute 'edit ' . sourcery#vimrc_path('plugins.vim')
    call s:go_to_ref(ref)
  elseif ref['type'] == 'local'
    silent execute 'edit ' . sourcery#vimrc_path('vimrc')
    call s:go_to_ref(ref)
  else
    echo 'Ref not found.'
  endif
endfunction

function! GoToRelatedVimrcMappings()
  if expand('%:t') == 'mappings.vim'
    echo 'Already in mappings.'
    return
  endif
  let ref = s:get_ref()
  silent execute 'edit ' sourcery#vimrc_path('mappings.vim')
  call s:go_to_ref(ref)
endfunction

function! GoToRelatedPlugDefinition()
  if match(getline('.'), "Plug '") > -1
    echo 'Already in plugin definitions.'
  endif
  let ref = s:get_ref()
  silent execute 'edit ' . sourcery#vimrc_path('plugins.vim')
  normal gg
  let query = get(g:explicit_annotation_bindings, ref['slug'], ref['slug'])
  let found = search("/.*" . query . ".*'\\c")
  if found == 0
    echo 'Plugin definition not found.'
  endif
endfunction

function! s:get_ref()
  if expand('%:t') == 'plugins.vim' && match(getline('.'), "Plug '") > -1
    return s:get_ref_from_plug_definition()
  elseif expand('%:t') == 'plugins.vim' || expand('%:t') == 'mappings.vim'
    return s:get_ref_from_annotation()
  else
    return s:get_ref_for_current_config_file()
  endif
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

function! s:get_ref_from_plug_definition()
  let matched = matchlist(getline('.'), "/\\(.*\\)'")[1]
  let fallback = substitute(matched, 'vim-', '', '')
  let fallback = substitute(fallback, '-vim', '', '')
  let fallback = substitute(fallback, '\.vim', '', '')
  return {
    \ 'type': 'plugin',
    \ 'slug': get(FlipDictionary(g:explicit_annotation_bindings), matched, fallback)
    \ }
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
" # Plugin Helper Commands
" ------------------------------------------------------------------------------

command! GoToPluginGithubUrl call GoToPluginGithubUrl()
command! PlugYankGithubUrl call PlugYankGithubUrl()
command! PlugPasteFromClipboard call PlugPasteFromClipboard()

function! GoToPluginGithubUrl()
  call PlugYankGithubUrl()
  call system('chrome-cli open ' . @+)
endfunction

function! PlugYankGithubUrl()
  normal ^wyi'
  let @+ = 'https://www.github.com/' . @+
  return @+
endfunction

function! PlugPasteFromClipboard()
  execute 'edit ' . sourcery#vimrc_path('plugins.vim')
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
