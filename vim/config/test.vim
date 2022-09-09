" ------------------------------------------------------------------------------
" # Test Settings
" ------------------------------------------------------------------------------

let test#php#patterns = {
  \ 'test':      ['\v^\s*function (\w*)\(', '\v^\s*public function (\w*)\('],
  \ 'namespace': [] }

let test#php#phpunit#executable = 'vendor/bin/phpunit'


" ------------------------------------------------------------------------------
" # Detect Default Test Strategy
" ------------------------------------------------------------------------------

function! DetectDefaultTestStrategy()
  if exists("g:test#strategy")
    return
  elseif match(system('tmux ls | grep attached'), 'runner:') > 0
    let g:test#strategy = "tslime"
  else
    let g:test#strategy = "neovim"
  endif
endfunction

augroup detect_default_test_strategy
  autocmd!
  autocmd BufReadPost */tests/* call DetectDefaultTestStrategy()
augroup END


" ------------------------------------------------------------------------------
" # Manually Swap Test Strategy
" ------------------------------------------------------------------------------

function! TestSwapStrategy()
  if get(g:, 'test#strategy', 'neovim') == 'neovim'
    let g:test#strategy = "tslime"
    echo "Test Strategy: tslime into 'runner' session"
  else
    let g:test#strategy = "neovim"
    echo "Test Strategy: neovim"
  endif
endfunction

command! TestSwapStrategy call TestSwapStrategy()
