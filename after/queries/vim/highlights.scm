;; vim: ft=query
;; extends

((function_definition
   (function_declaration
     name: (scoped_identifier
             (scope) @_scope
             (identifier) @AlabasterDefinition)))
 (#any-of? @_scope "g:" "s:"))

(function_definition
  (function_declaration
    name: (identifier) @AlabasterDefinition))

(function_definition
  (function_declaration
    name: (field_expression
            field: (identifier) @AlabasterDefinition)))

(command_statement
  name: (command_name) @AlabasterDefinition)

(highlight_statement
  (hl_group) @AlabasterDefinition
  .
  (hl_attribute))

(highlight_statement
  from: (hl_group) @AlabasterDefinition)

((scoped_identifier
   (scope) @_scope
   (identifier) @AlabasterConstant)
 (#eq? @_scope "v:")
 (#any-of? @AlabasterConstant
   "none"
   "null"))
