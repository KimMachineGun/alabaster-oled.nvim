;; vim: ft=query
;; extends

(global_form
  (binding_pair
    lhs: [
      (symbol_binding) @AlabasterDefinition
      (sequence_binding
        (symbol_binding) @AlabasterDefinition)
      (list_binding
        (symbol_binding) @AlabasterDefinition)
      (table_binding
        (table_binding_pair
          value: (symbol_binding) @AlabasterDefinition))
    ]))

(program
  [
    (fn_form
      name: [
        (symbol) @AlabasterDefinition
        (multi_symbol
          member: (symbol_fragment) @AlabasterDefinition .)
      ])
    (lambda_form
      name: [
        (symbol) @AlabasterDefinition
        (multi_symbol
          member: (symbol_fragment) @AlabasterDefinition .)
      ])
    (macro_form
      name: [
        (symbol) @AlabasterDefinition
        (multi_symbol
          member: (symbol_fragment) @AlabasterDefinition .)
      ])
  ])

([
   (string)
   (string_binding)
 ] @AlabasterConstant
  (#lua-match? @AlabasterConstant "^:"))

(quote_reader_macro
  expression: (multi_symbol) @AlabasterConstant)

(quote_reader_macro
  expression: (symbol) @AlabasterConstant)
