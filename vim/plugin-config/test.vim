" ------------------------------------------------------------------------------
" # Test Settings
" ------------------------------------------------------------------------------

let test#php#patterns = {
  \ 'test':      ['\v^\s*function (\w*)\(', '\v^\s*public function (\w*)\('],
  \ 'namespace': [] }

let test#php#phpunit#executable = 'vendor/bin/phpunit'

let test#php#phpunit#options = {
  \ 'nearest': '--testdox',
  \ 'file':    '--testdox',
  \ }

let g:shtuff_receiver = 'test'


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
