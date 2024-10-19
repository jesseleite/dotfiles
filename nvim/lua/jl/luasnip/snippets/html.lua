local aliasable_tag_pair_contents = function (params)
  local alias = string.match(params[1][1], ' as="(.-)"')

  if not alias then
    return sn(nil, i(1, '{{ title }}'))
  end

  return sn(nil, fmt('{{{{ '..alias..' }}}}\n        {}\n    {{{{ /'..alias..' }}}}', {
    i(1, "{{ title }}")
  }))
end

return {

  -- collection tag
  s('col', fmt('{{{{ collection:{}{} }}}}\n    {}\n{{{{ /collection:{} }}}}', {
    i(1),
    i(2),
    d(3, aliasable_tag_pair_contents, { 2 }),
    extras.rep(1),
  })),

}
