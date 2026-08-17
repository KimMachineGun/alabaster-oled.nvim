;; vim: ft=query
;; extends

; Identifier spelling alone never proves a constant or definition.
(identifier) @AlabasterBase

((chunk
   (function_declaration
     name: (identifier) @AlabasterDefinition) @_declaration)
 (#not-match? @_declaration "^local\\s"))

; A function declared on a table at chunk scope is a structural API definition.
(chunk
  (function_declaration
    name: [
      (dot_index_expression
        field: (identifier) @AlabasterDefinition)
      (method_index_expression
        method: (identifier) @AlabasterDefinition)
    ]))

; Limit assignment syntax to one chunk-level field and one function value.
(chunk
  (assignment_statement
    (variable_list
      .
      name: (dot_index_expression
        field: (identifier) @AlabasterDefinition)
      .)
    (expression_list
      .
      value: (function_definition)
      .)))

(table_constructor
  (field name: (identifier) @AlabasterString))

(chunk
  (return_statement
    (expression_list
      (table_constructor
        (field
          name: (identifier) @AlabasterDefinition
          value: (function_definition))))))

(hash_bang_line) @AlabasterHashbang
