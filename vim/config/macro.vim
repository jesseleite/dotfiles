" ------------------------------------------------------------------------------
" # Macro Helpers
" ------------------------------------------------------------------------------

function! PlaybackMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
