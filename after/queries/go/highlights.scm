;; vim: ft=query
;; extends

(package_clause
  (package_identifier) @AlabasterDefinition)

(source_file
  (var_declaration
    (var_spec
      name: (identifier) @AlabasterDefinition)))

(source_file
  (var_declaration
    (var_spec_list
      (var_spec
        name: (identifier) @AlabasterDefinition))))

(source_file
  (type_declaration
    (type_spec
      name: (type_identifier) @AlabasterDefinition)))

(const_declaration
  (const_spec
    name: (identifier) @AlabasterDefinition))

(function_declaration
  name: (identifier) @AlabasterDefinition)

(method_declaration
  name: (field_identifier) @AlabasterDefinition)
