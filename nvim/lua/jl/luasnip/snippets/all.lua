return {

  -- Expand after opening parens/braces to pad pair (ie. `[ ... ]`, `{ ... }`, etc.)
  s('(', fmt('( {} ', { i(0) })),
  s('[', fmt('[ {} ', { i(0) })),
  s('{', fmt('{{ {} ', { i(0) })),

}
