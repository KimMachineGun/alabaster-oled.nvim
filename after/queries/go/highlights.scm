;; vim: ft=query
;; extends

(package_clause
  (package_identifier) @AlabasterDefinition)

((var_spec
  name: (identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition block))

([
  (type_spec
    name: (type_identifier) @AlabasterDefinition)
  (type_alias
    name: (type_identifier) @AlabasterDefinition)
] @_definition
  (#not-has-ancestor? @_definition block))

(const_spec
  (identifier) @AlabasterConstant)

(function_declaration
  name: (identifier) @AlabasterDefinition)

(method_declaration
  name: (field_identifier) @AlabasterDefinition)

((method_elem
  name: (field_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition block))
