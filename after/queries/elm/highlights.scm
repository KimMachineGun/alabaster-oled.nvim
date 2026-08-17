;; vim: ft=query
;; extends

; Module/global definitions. The file parent excludes let-local declarations.
(file
  (module_declaration
    name: (upper_case_qid
      (upper_case_identifier) @AlabasterDefinition)))

(file
  (type_annotation
    name: (lower_case_identifier) @AlabasterDefinition))

(file
  (value_declaration
    functionDeclarationLeft: (function_declaration_left
      (lower_case_identifier) @AlabasterDefinition)))

(file
  (port_annotation
    name: (lower_case_identifier) @AlabasterDefinition))

(file
  (type_declaration
    name: (upper_case_identifier) @AlabasterDefinition
    (union_variant
      name: (upper_case_identifier) @AlabasterConstant)))

(file
  (type_alias_declaration
    name: (upper_case_identifier) @AlabasterDefinition))

(file
  (infix_declaration
    operator: (operator_identifier) @AlabasterDefinition))

; Covers infix precedence as well as ordinary numeric literals.
(number_literal) @AlabasterConstant
