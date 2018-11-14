function! FlipDictionary(dictionary)
  let flipped = {}
  for [key, value] in items(a:dictionary)
    let flipped[value] = key
  endfor
  return flipped
endfunction
