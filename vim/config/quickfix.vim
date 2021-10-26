" ------------------------------------------------------------------------------
" # Register Quickfix Local Mappings
" ------------------------------------------------------------------------------

augroup quickfix_mappings
  autocmd!
  autocmd FileType qf call QuickfixLocalMappings()
augroup END


" ------------------------------------------------------------------------------
" # Quickfix Helpers
" ------------------------------------------------------------------------------

" When using `dd` in the quickfix list, remove the item from the quickfix list.
" https://stackoverflow.com/questions/42905008/quickfix-list-how-to-add-and-remove-entries
function! RemoveQuickfixItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  copen
endfunction

function! PreviewQuickfixItem()
  .cc
  wincmd j
endfunction

function! TelescopeQuickfix()
  cclose
  Telescope quickfix
endfunction
