;; vim: ft=query
;; extends

((field_identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition field_declaration init_declarator pointer_declarator reference_declarator array_declarator function_declarator parenthesized_declarator)
  (#has-ancestor? @AlabasterDefinition field_declaration function_definition)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration))

((identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition reference_declarator structured_binding_declarator)
  (#has-ancestor? @AlabasterDefinition declaration function_definition)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration field_declaration))

((identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition qualified_identifier destructor_name)
  (#has-ancestor? @AlabasterDefinition function_declarator)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration))

((operator_name) @AlabasterDefinition
  (#has-ancestor? @AlabasterDefinition function_declarator)
  (#not-has-ancestor? @AlabasterDefinition compound_statement parameter_declaration))

((declaration
  declarator: (qualified_identifier
    name: (identifier) @AlabasterDefinition)) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration))

((declaration
  declarator: (init_declarator
    declarator: (qualified_identifier
      name: (identifier) @AlabasterDefinition))) @_definition
  (#not-has-ancestor? @_definition compound_statement field_declaration))

((identifier) @AlabasterDefinition
  (#has-parent? @AlabasterDefinition qualified_identifier)
  (#has-ancestor? @AlabasterDefinition pointer_declarator reference_declarator array_declarator)
  (#has-ancestor? @AlabasterDefinition declaration)
  (#not-has-ancestor? @AlabasterDefinition function_declarator compound_statement parameter_declaration field_declaration))

((class_specifier
  name: (type_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((alias_declaration
  name: (type_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((concept_definition
  name: (identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((namespace_definition
  name: (namespace_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((namespace_definition
  name: (nested_namespace_specifier
    (namespace_identifier) @AlabasterDefinition)) @_definition
  (#not-has-ancestor? @_definition compound_statement))

((namespace_alias_definition
  name: (namespace_identifier) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition compound_statement))
