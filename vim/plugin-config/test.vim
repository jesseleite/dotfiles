" ------------------------------------------------------------------------------
" # Test Settings
" ------------------------------------------------------------------------------

let test#php#patterns = {
  \ 'test':      ['\v^\s*function (\w*)\(', '\v^\s*public function (\w*)\('],
  \ 'namespace': [] }


" ------------------------------------------------------------------------------
" # Setup Shtuff Test Strategy
" ------------------------------------------------------------------------------

function! ShtuffStrategy(cmd)
  call system("shtuff into test " . shellescape("clear;" . a:cmd))
endfunction

let g:test#custom_strategies = {'shtuff': function('ShtuffStrategy')}


" ------------------------------------------------------------------------------
" # Detect Default Test Strategy
" ------------------------------------------------------------------------------

function! DetectDefaultTestStrategy()
  if exists("g:test#strategy")
    return
  elseif match(system('shtuff has test'), 'was found') > 0
    let g:test#strategy = "shtuff"
  else
    let g:test#strategy = "basic"
  endif
endfunction

augroup detect_default_test_strategy
  autocmd!
  autocmd BufReadPost */tests/* call DetectDefaultTestStrategy()
augroup END


" ------------------------------------------------------------------------------
" # Manually Toggle Test Strategy
" ------------------------------------------------------------------------------

function! TestToggleStrategy()
  if get(g:, 'test#strategy', 'basic') == 'basic'
    let g:test#strategy = "shtuff"
    echo "Test Strategy: shtuff into test"
  else
    let g:test#strategy = "basic"
    echo "Test Strategy: basic"
  endif
endfunction

command! TestToggleStrategy call TestToggleStrategy()
