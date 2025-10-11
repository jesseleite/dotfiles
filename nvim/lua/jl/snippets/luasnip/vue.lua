return {

  -- Import
  s('vue', fmt('<script setup>\nimport {{ ref, computed, watch, onMounted }} from \'vue\';\n\n{}\n</script>\n\n<template>\n\tHello world!\n</template>', i(0))),

  -- Vue ref
  s('ref', fmt('const {} = ref({});', { i(1, 'val'), i(0) })),

  -- Vue computed
  s('comp', fmt('const {} = computed(() => {{{}}});', { i(1, 'val'), i(0) })),

  -- Vue watcher
  s('watch', fmt('watch({}, (value) => {{\n\t{}\n}});', { i(1, 'val'), i(0) })),

  -- Vue onMounted
  s('mount', fmt('onMounted(() => {{\n\t{}\n}});', { i(0) })),

}
