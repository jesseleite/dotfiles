" ------------------------------------------------------------------------------
" # Laravel Helpers
" ------------------------------------------------------------------------------

function! LaravelUnserializeCache()
  silent exec "!ray --json $(php -r \"echo json_encode(unserialize(substr(trim('" . escape(getline('.'), '"') . "'), 10)));\")"
endfunction

function! LaravelConvertToRealTimeFacade()
  let classUnderCursor = expand("<cword>")
  call search('use .*\\'.classUnderCursor, 'sb')
  s/use /use Facades\\/
endfunction


" ------------------------------------------------------------------------------
" # Experimenting...
" ------------------------------------------------------------------------------

function! LaravelGoToDefinition()
  call LaravelGoToView()
endfunction

function! LaravelGoToView()
  let line = getline(line('.'))
  let pattern = 'view([''"]\([^''"]*\)[''"]'
  if match(line, pattern) == -1
    echo 'Nowhere to go?'
    return
  endif
  let view = matchlist(line, pattern)[1]
  let localView = substitute(view, '.*::', '', '')
  let path = 'resources/views/' . substitute(localView, '\.', '/', 'g') . '.blade.php'
  if filereadable(path)
    execute 'edit ' . path
  else
    echo 'Cannot find view.'
  endif
endfunction

" nmap <Leader>il :call LaravelGoToDefinition()<CR>

" Need to be able to go through these...
" return view('some.view.here');
" return view("some.view.here");
" return view('statamic::addons.index', [
"     'title' => 'Addons'
" ]);
" return view('statamic::widgets.collection', compact('collection', 'title', 'button', 'limit'));
