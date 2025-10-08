;; extends

; Extend function text objects to include additional macros like `test`, describe`, etc.
(call
  target: ((identifier) @_identifier
    (#any-of? @_identifier "describe" "setup" "test"))
  [
    (do_block
      "do"
      .
      (_) @_do
      (_) @_end
      .
      "end")
    (do_block
      "do"
      .
      ((_) @_do) @_end
      .
      "end")
  ]
  (#make-range! "function.inner" @_do @_end)) @function.outer
