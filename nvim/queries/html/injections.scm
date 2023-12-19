;; extends

((element
  (start_tag
    (attribute
      (attribute_name) @_name
      (quoted_attribute_value (attribute_value) @injection.content))))
 (#eq? @_name "x-data")
  (#set! injection.language javascript))
