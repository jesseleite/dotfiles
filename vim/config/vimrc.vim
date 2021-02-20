" ------------------------------------------------------------------------------
" # Basic Edit Commands
" ------------------------------------------------------------------------------

command! EditVimrc call EditVimConfig('vimrc')
command! EditVimMappings call EditVimConfig('mappings.vim')
command! EditVimPlugins call EditVimConfig('plugins.vim')

function! EditVimConfig(file)
  execute 'edit ' . sourcery#vim_dotfiles_path(a:file)
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
  execute 'edit ' . sourcery#vim_dotfiles_path('plugins.vim')
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
