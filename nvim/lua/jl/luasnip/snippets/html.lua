local aliasable_tag_pair_contents = function (params)
  local alias = string.match(params[1][1], ' as="(.-)"')

  if not alias then
    return sn(nil, i(1, '{{ title }}'))
  end

  return sn(nil, fmt('{{{{ '..alias..' }}}}\n        {}\n    {{{{ /'..alias..' }}}}', {
    i(1, "{{ title }}")
  }))
end

local closing_tag_without_params = function (tag)
  return string.match(tag[1][1], '(.-)%s')
end

return {

  -- Collection tag
  s('col', fmt('{{{{ collection:{} }}}}\n    {}\n{{{{ /collection:{} }}}}', {
    i(1),
    d(2, aliasable_tag_pair_contents, { 1 }),
    f(closing_tag_without_params, { 1 })
  })),

}
