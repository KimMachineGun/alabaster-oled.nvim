;; vim: ft=query
;; extends

; Naming convention alone does not prove that an identifier is constant.
((identifier) @AlabasterBase
  (#lua-match? @AlabasterBase "^[A-Z_][A-Z%d_]+$"))

[
  (package_declaration
    [(identifier) (scoped_identifier)] @AlabasterDefinition)
  (module_declaration
    name: [(identifier) (scoped_identifier)] @AlabasterDefinition)
]

(program
  [
    (class_declaration name: (identifier) @AlabasterDefinition)
    (interface_declaration name: (identifier) @AlabasterDefinition)
    (annotation_type_declaration name: (identifier) @AlabasterDefinition)
    (record_declaration name: (identifier) @AlabasterDefinition)
    (enum_declaration name: (identifier) @AlabasterDefinition)
  ])

(class_body
  [
    (class_declaration name: (identifier) @AlabasterDefinition)
    (interface_declaration name: (identifier) @AlabasterDefinition)
    (annotation_type_declaration name: (identifier) @AlabasterDefinition)
    (record_declaration name: (identifier) @AlabasterDefinition)
    (enum_declaration name: (identifier) @AlabasterDefinition)
  ])

(interface_body
  [
    (class_declaration name: (identifier) @AlabasterDefinition)
    (interface_declaration name: (identifier) @AlabasterDefinition)
    (annotation_type_declaration name: (identifier) @AlabasterDefinition)
    (record_declaration name: (identifier) @AlabasterDefinition)
    (enum_declaration name: (identifier) @AlabasterDefinition)
  ])

(annotation_type_body
  [
    (class_declaration name: (identifier) @AlabasterDefinition)
    (interface_declaration name: (identifier) @AlabasterDefinition)
    (annotation_type_declaration name: (identifier) @AlabasterDefinition)
    (record_declaration name: (identifier) @AlabasterDefinition)
    (enum_declaration name: (identifier) @AlabasterDefinition)
  ])

(enum_body_declarations
  [
    (class_declaration name: (identifier) @AlabasterDefinition)
    (interface_declaration name: (identifier) @AlabasterDefinition)
    (annotation_type_declaration name: (identifier) @AlabasterDefinition)
    (record_declaration name: (identifier) @AlabasterDefinition)
    (enum_declaration name: (identifier) @AlabasterDefinition)
  ])

[
  (constructor_declaration
    name: (identifier) @AlabasterDefinition)
  (compact_constructor_declaration
    name: (identifier) @AlabasterDefinition)
  (method_declaration
    name: (identifier) @AlabasterDefinition)
  (annotation_type_element_declaration
    name: (identifier) @AlabasterDefinition)
]

(field_declaration
  declarator: (variable_declarator
    name: (identifier) @AlabasterDefinition))

(record_declaration
  parameters: (formal_parameters
    (formal_parameter
      name: (identifier) @AlabasterDefinition)))

; Interface constants and enum entries are constants by grammar, not convention.
(constant_declaration
  declarator: (variable_declarator
    name: (identifier) @AlabasterConstant))

(enum_constant
  name: (identifier) @AlabasterConstant)
