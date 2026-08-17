;; vim: ft=query
;; extends

(package_clause
  (package_identifier) @AlabasterDefinition)

; Top-level definitions.
(compilation_unit
  [
    (function_definition
      name: (identifier) @AlabasterDefinition)
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (class_definition
      name: (identifier) @AlabasterDefinition)
    (object_definition
      name: (identifier) @AlabasterDefinition)
    (trait_definition
      name: (identifier) @AlabasterDefinition)
    (enum_definition
      name: (identifier) @AlabasterDefinition)
    (type_definition
      name: (type_identifier) @AlabasterDefinition)
    (val_definition
      pattern: (identifier) @AlabasterDefinition)
    (var_definition
      pattern: (identifier) @AlabasterDefinition)
    (val_declaration
      name: (identifier) @AlabasterDefinition)
    (var_declaration
      name: (identifier) @AlabasterDefinition)
    (given_definition
      name: (identifier) @AlabasterDefinition)
  ])

; Class, trait, and object members.
(template_body
  [
    (function_definition
      name: (identifier) @AlabasterDefinition)
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (class_definition
      name: (identifier) @AlabasterDefinition)
    (object_definition
      name: (identifier) @AlabasterDefinition)
    (trait_definition
      name: (identifier) @AlabasterDefinition)
    (enum_definition
      name: (identifier) @AlabasterDefinition)
    (type_definition
      name: (type_identifier) @AlabasterDefinition)
    (val_definition
      pattern: (identifier) @AlabasterDefinition)
    (var_definition
      pattern: (identifier) @AlabasterDefinition)
    (val_declaration
      name: (identifier) @AlabasterDefinition)
    (var_declaration
      name: (identifier) @AlabasterDefinition)
    (given_definition
      name: (identifier) @AlabasterDefinition)
  ])

; Enum members and methods.
(enum_body
  [
    (function_definition
      name: (identifier) @AlabasterDefinition)
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (type_definition
      name: (type_identifier) @AlabasterDefinition)
    (val_definition
      pattern: (identifier) @AlabasterDefinition)
    (var_definition
      pattern: (identifier) @AlabasterDefinition)
  ])

(simple_enum_case
  name: (identifier) @AlabasterConstant)

(full_enum_case
  name: (identifier) @AlabasterConstant)

(full_enum_case
  class_parameters: (class_parameters
    (class_parameter
      name: (identifier) @AlabasterDefinition)))

; Explicit val/var parameters and all case-class parameters are members.
(class_parameter
  ["val" "var"]
  name: (identifier) @AlabasterDefinition)

(class_definition
  "case"
  class_parameters: (class_parameters
    (class_parameter
      name: (identifier) @AlabasterDefinition)))

; Top-level and member extension methods are structural API definitions.
(compilation_unit
  (extension_definition
    body: (function_definition
      name: (identifier) @AlabasterDefinition)))

(template_body
  (extension_definition
    body: (function_definition
      name: (identifier) @AlabasterDefinition)))

(compilation_unit
  (extension_definition
    body: (indented_block
      (function_definition
        name: (identifier) @AlabasterDefinition))))

(template_body
  (extension_definition
    body: (indented_block
      (function_definition
        name: (identifier) @AlabasterDefinition))))

(with_template_body
  [
    (function_definition
      name: (identifier) @AlabasterDefinition)
    (function_declaration
      name: (identifier) @AlabasterDefinition)
    (val_definition
      pattern: (identifier) @AlabasterDefinition)
    (var_definition
      pattern: (identifier) @AlabasterDefinition)
  ])
