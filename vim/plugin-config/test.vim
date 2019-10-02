let test#php#patterns = {
  \ 'test':      ['\v^\s*function (\w*)\(', '\v^\s*public function (\w*)\('],
  \ 'namespace': [] }

function! ShtuffStrategy(cmd)
  call system("shtuff into " . shellescape(g:shtuff_as) . " " . shellescape("clear;" . a:cmd))
endfunction

function! TestToggleStrategy()
  if exists("g:test#strategy")
    unlet g:test#strategy
    echo "Test Strategy: default"
  else
    let g:test#strategy = "shtuff"
    echo "Test Strategy: shtuff into test"
  endif
endfunction

command! TestToggleStrategy call TestToggleStrategy()

let g:shtuff_as = "test"
let g:test#custom_strategies = {'shtuff': function('ShtuffStrategy')}

function! DetectDefaultTestStrategy()
  if exists("g:test#strategy")
    return
  elseif match(system('shtuff has test'), 'was found') > 0
    let g:test#strategy = "shtuff"
  endif
endfunction

augroup detect_default_test_strategy
  autocmd!
  autocmd BufReadPost */tests/* call DetectDefaultTestStrategy()
augroup END
