;; vim: ft=query
;; extends

(identifier) @AlabasterBase

((identifier) @AlabasterConstant
  (#any-of? @AlabasterConstant "NotImplemented" "Ellipsis" "__debug__"))

((function_definition
  name: (identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition function_definition))

((class_definition
  name: (identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition function_definition))

((assignment
  left: (identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition function_definition))

((identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition pattern_list tuple_pattern list_pattern list_splat_pattern)
  (#has-ancestor? @AlabasterDefinition assignment)
  (#not-has-ancestor? @AlabasterDefinition function_definition for_in_clause))

((type_alias_statement
  left: (type
    (identifier) @AlabasterDefinition)) @_definition
  (#not-has-ancestor? @_definition function_definition))

(ellipsis) @AlabasterConstant

((module . (comment) @AlabasterHashbang)
 (#match? @AlabasterHashbang "^#!/"))

(decorator
  (identifier) @AlabasterBase)
