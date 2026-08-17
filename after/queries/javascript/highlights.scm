;; vim: ft=query
;; extends

; Naming convention alone is not enough to prove that an identifier is constant.
((identifier) @AlabasterBase
  (#lua-match? @AlabasterBase "^_*[A-Z][A-Z%d_]*$"))

((shorthand_property_identifier) @AlabasterBase
  (#lua-match? @AlabasterBase "^_*[A-Z][A-Z%d_]*$"))

; Module/global definitions. The program parent excludes nested declarations.
(program
  [
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (generator_function_declaration
      name: (identifier) @AlabasterDefinition)
    (class_declaration
      name: (identifier) @AlabasterDefinition)
    (lexical_declaration
      (variable_declarator
        name: (identifier) @AlabasterDefinition))
    (variable_declaration
      (variable_declarator
        name: (identifier) @AlabasterDefinition))
  ])

(program
  (export_statement
    declaration: [
      (function_declaration
        name: (identifier) @AlabasterDefinition)
      (generator_function_declaration
        name: (identifier) @AlabasterDefinition)
      (class_declaration
        name: (identifier) @AlabasterDefinition)
      (lexical_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
      (variable_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
    ]))

; Binding leaves cover recursively nested top-level destructuring patterns.
([
  (shorthand_property_identifier_pattern) @AlabasterDefinition
  (pair_pattern value: (identifier) @AlabasterDefinition)
  (rest_pattern (identifier) @AlabasterDefinition)
  (array_pattern (identifier) @AlabasterDefinition)
  (assignment_pattern left: (identifier) @AlabasterDefinition)
 ]
  (#has-ancestor? @AlabasterDefinition variable_declarator)
  (#not-has-ancestor? @AlabasterDefinition statement_block for_in_statement for_statement switch_body))

; Class members are structural definitions; object-literal members are not.
(class_body
  (method_definition
    name: [
      (property_identifier)
      (private_property_identifier)
    ] @AlabasterDefinition))

(class_body
  (field_definition
    property: [
      (property_identifier)
      (private_property_identifier)
    ] @AlabasterDefinition))
