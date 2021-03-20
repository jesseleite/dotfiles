" ------------------------------------------------------------------------------
" # Plugin Helper Commands
" ------------------------------------------------------------------------------

command! UseLocalPluginRepo call UseLocalPluginRepo()
command! GoToPluginGithubUrl call GoToPluginGithubUrl()
command! PlugYankGithubUrl call PlugYankGithubUrl()
command! PlugPasteFromClipboard call PlugPasteFromClipboard()

function! UseLocalPluginRepo()
   s/'[^/]\+/'\/Users\/jesseleite\/Code/
endfunction

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
  normal o
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
