return {

  -- Console log
  s('cl', fmt('console.log({});', i(0))),

  -- Vue ref
  s('vref', fmt('const {} = ref({});', { i(1, 'val'), i(0) })),

  -- Vue computed
  s('vcomp', fmt('const {} = computed(() => {{{}}});', { i(1, 'val'), i(0) })),

  -- Vue watcher
  s('vwatch', fmt('watch({}, (value) => {{\n\t{}\n}});', { i(1, 'val'), i(0) })),

  -- Vue onMounted
  s('vmount', fmt('onMounted(() => {{\n\t{}\n}});', { i(0) })),

}
