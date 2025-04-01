return {

  -- Function
  s('func', fmt('func {}({}) {}{{\n    {}\n}}', { i(1), i(2), i(3), i(0) })),

  -- Method
  s('met', fmt('func ({}) {}({}) {}{{\n    {}\n}}', { i(1, 'r Receiver'), i(2, 'Name'), i(3), i(4), i(0) })),

  -- For loop
  s('for', fmt('for {}; {}; {} {{\n    {}\n}}', { i(1, 'i := 0'), i(2, 'i < 5'), i(3, 'i++'), i(0) })),

  -- For range loop
  s('forr', fmt('for {} := range {} {{\n    {}\n}}', { i(1, 'key, value'), i(2, 'values'), i(0) })),

  -- Test function
  s('test', fmt('func Test{}(t *testing.T) {{\n    {}\n}}', { i(1, 'Name'), i(0) })),

  -- Subtest function
  s('stest', fmt('t.Run("{}", func(t *testing.T) {{\n    {}\n}})', { i(1, 'name'), i(0) })),

}
