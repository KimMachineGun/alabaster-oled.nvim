;; vim: ft=query
;; extends

(identifier) @AlabasterBase

[
  (preproc_def
    name: (_) @AlabasterConstant)
  (preproc_function_def
    name: (identifier) @AlabasterConstant)
  (enumerator
    name: (identifier) @AlabasterConstant)
]

((field_identifier) @AlabasterDefinition
  (#has-ancestor? @AlabasterDefinition field_declaration)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration))

((identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition declaration pointer_declarator array_declarator function_declarator parenthesized_declarator)
  (#has-ancestor? @AlabasterDefinition declaration function_definition)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration field_declaration))

((declaration
  declarator: (init_declarator
    declarator: (identifier) @AlabasterDefinition)) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration))

((type_definition
  declarator: (type_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((type_identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition pointer_declarator array_declarator function_declarator parenthesized_declarator)
  (#has-ancestor? @AlabasterDefinition type_definition)
  (#not-has-ancestor? @AlabasterDefinition compound_statement))

((struct_specifier
  name: (type_identifier) @AlabasterDefinition
  body: (field_declaration_list)) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration parameter_declaration))

((struct_specifier
  name: (type_identifier) @AlabasterDefinition
  !body) @_definition
  (#not-has-parent? @_definition declaration field_declaration parameter_declaration type_definition)
  (#not-has-ancestor? @_definition compound_statement))

((union_specifier
  name: (type_identifier) @AlabasterDefinition
  body: (field_declaration_list)) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration parameter_declaration))

((union_specifier
  name: (type_identifier) @AlabasterDefinition
  !body) @_definition
  (#not-has-parent? @_definition declaration field_declaration parameter_declaration type_definition)
  (#not-has-ancestor? @_definition compound_statement))

((enum_specifier
  name: (type_identifier) @AlabasterDefinition
  body: (enumerator_list)) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration parameter_declaration))

((enum_specifier
  name: (type_identifier) @AlabasterDefinition
  !body) @_definition
  (#not-has-parent? @_definition declaration field_declaration parameter_declaration type_definition)
  (#not-has-ancestor? @_definition compound_statement))
