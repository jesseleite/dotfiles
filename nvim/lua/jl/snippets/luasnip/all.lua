return {

  -- Expand after opening parens/braces to pad pair (ie. `[ ... ]`, `{ ... }`, etc.)
  s({ trig = '( ', snippetType = 'autosnippet' }, fmt('( {} ', { i(0) })),
  s({ trig = '[ ', snippetType = 'autosnippet' }, fmt('[ {} ', { i(0) })),
  s({ trig = '{ ', snippetType = 'autosnippet' }, fmt('{{ {} ', { i(0) })),

}
