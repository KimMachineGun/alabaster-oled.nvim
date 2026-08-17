;; vim: ft=query
;; extends

; Reset the all-caps naming heuristic; declarations below are parser-confirmed.
(identifier) @AlabasterBase

(declarations
  [
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (type_declaration
      (identifier) @AlabasterDefinition)
    (global_declaration
      (global_binding
        (identifier) @AlabasterDefinition))
  ])

; Struct/union fields are structural definitions.
(field
  (identifier) @AlabasterDefinition)

; `def` declarations and enum entries are constants by grammar.
(declarations
  (constant_declaration
    (identifier) @AlabasterConstant))

(enum_field
  (identifier) @AlabasterConstant)
