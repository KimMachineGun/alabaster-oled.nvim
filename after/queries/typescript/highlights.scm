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
    (interface_declaration
      name: (type_identifier) @AlabasterDefinition)
    (type_alias_declaration
      name: (type_identifier) @AlabasterDefinition)
    (enum_declaration
      name: (identifier) @AlabasterDefinition)
    (class_declaration
      name: (type_identifier) @AlabasterDefinition)
    (abstract_class_declaration
      name: (type_identifier) @AlabasterDefinition)
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (generator_function_declaration
      name: (identifier) @AlabasterDefinition)
    (function_signature
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
      (interface_declaration
        name: (type_identifier) @AlabasterDefinition)
      (type_alias_declaration
        name: (type_identifier) @AlabasterDefinition)
      (enum_declaration
        name: (identifier) @AlabasterDefinition)
      (class_declaration
        name: (type_identifier) @AlabasterDefinition)
      (abstract_class_declaration
        name: (type_identifier) @AlabasterDefinition)
      (function_declaration
        name: (identifier) @AlabasterDefinition)
      (generator_function_declaration
        name: (identifier) @AlabasterDefinition)
      (function_signature
        name: (identifier) @AlabasterDefinition)
      (lexical_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
      (variable_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
    ]))

; `declare` forms are module/global declarations even when wrapped for ambient syntax.
(ambient_declaration
  [
    (interface_declaration
      name: (type_identifier) @AlabasterDefinition)
    (type_alias_declaration
      name: (type_identifier) @AlabasterDefinition)
    (enum_declaration
      name: (identifier) @AlabasterDefinition)
    (class_declaration
      name: (type_identifier) @AlabasterDefinition)
    (abstract_class_declaration
      name: (type_identifier) @AlabasterDefinition)
    (function_signature
      name: (identifier) @AlabasterDefinition)
    (lexical_declaration
      (variable_declarator
        name: (identifier) @AlabasterDefinition))
    (variable_declaration
      (variable_declarator
        name: (identifier) @AlabasterDefinition))
  ])

; Declarations inside `declare global` are global despite the statement block.
(ambient_declaration
  (statement_block
    [
      (interface_declaration
        name: (type_identifier) @AlabasterDefinition)
      (type_alias_declaration
        name: (type_identifier) @AlabasterDefinition)
      (enum_declaration
        name: (identifier) @AlabasterDefinition)
      (class_declaration
        name: (type_identifier) @AlabasterDefinition)
      (abstract_class_declaration
        name: (type_identifier) @AlabasterDefinition)
      (function_signature
        name: (identifier) @AlabasterDefinition)
      (lexical_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
      (variable_declaration
        (variable_declarator
          name: (identifier) @AlabasterDefinition))
    ]))

; Class and type members are structural definitions.
(class_body
  [
    (method_definition
      name: [
        (property_identifier)
        (private_property_identifier)
      ] @AlabasterDefinition)
    (method_signature
      name: (property_identifier) @AlabasterDefinition)
    (abstract_method_signature
      name: (property_identifier) @AlabasterDefinition)
    (public_field_definition
      name: [
        (property_identifier)
        (private_property_identifier)
      ] @AlabasterDefinition)
  ])

; Namespace declarations are wrapped in expression statements by the parser.
(internal_module
  name: (identifier) @AlabasterDefinition)

; Exported declarations inside namespaces are module definitions.
([
  (interface_declaration
    name: (type_identifier) @AlabasterDefinition)
  (type_alias_declaration
    name: (type_identifier) @AlabasterDefinition)
  (enum_declaration
    name: (identifier) @AlabasterDefinition)
  (class_declaration
    name: (type_identifier) @AlabasterDefinition)
  (abstract_class_declaration
    name: (type_identifier) @AlabasterDefinition)
  (function_declaration
    name: (identifier) @AlabasterDefinition)
  (generator_function_declaration
    name: (identifier) @AlabasterDefinition)
  (function_signature
    name: (identifier) @AlabasterDefinition)
 ]
  (#has-ancestor? @AlabasterDefinition export_statement)
  (#has-ancestor? @AlabasterDefinition internal_module))

; Namespace variables must be the export's direct declaration, not function locals.
(internal_module
  body: (statement_block
    (export_statement
      declaration: [
        (lexical_declaration
          (variable_declarator
            name: (identifier) @AlabasterDefinition))
        (variable_declaration
          (variable_declarator
            name: (identifier) @AlabasterDefinition))
      ])))

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

; Namespace exports have one unavoidable statement-block ancestor.
([
  (shorthand_property_identifier_pattern) @AlabasterDefinition
  (pair_pattern value: (identifier) @AlabasterDefinition)
  (rest_pattern (identifier) @AlabasterDefinition)
  (array_pattern (identifier) @AlabasterDefinition)
  (assignment_pattern left: (identifier) @AlabasterDefinition)
 ]
  (#has-ancestor? @AlabasterDefinition variable_declarator)
  (#has-ancestor? @AlabasterDefinition export_statement)
  (#has-ancestor? @AlabasterDefinition internal_module)
  (#not-has-ancestor? @AlabasterDefinition function_declaration generator_function_declaration function_expression arrow_function method_definition))

(interface_body
  [
    (method_signature
      name: (property_identifier) @AlabasterDefinition)
    (property_signature
      name: (property_identifier) @AlabasterDefinition)
  ])

(object_type
  [
    (method_signature
      name: (property_identifier) @AlabasterDefinition)
    (property_signature
      name: (property_identifier) @AlabasterDefinition)
  ])

; Enum members are statically known constants, not global definitions.
(enum_body
  [
    (property_identifier) @AlabasterConstant
    (enum_assignment
      name: (property_identifier) @AlabasterConstant)
  ])
