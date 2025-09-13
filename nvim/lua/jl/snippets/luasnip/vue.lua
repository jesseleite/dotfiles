return {

  -- Import
  s('vue', fmt('<script setup>\nimport {{ ref, computed, watch, onMounted }} from \'vue\';\n\n{}\n</script>\n\n<template>\n\tHello world!\n</template>', i(0))),

}
