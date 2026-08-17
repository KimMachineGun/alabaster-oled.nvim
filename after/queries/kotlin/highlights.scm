;; vim: ft=query
;; extends

; Naming convention alone does not prove that an identifier is constant.
((simple_identifier) @AlabasterBase
  (#lua-match? @AlabasterBase "^[A-Z][A-Z0-9_]*$"))

(package_header
  (identifier
    (simple_identifier) @AlabasterDefinition))

; Top-level definitions.
(source_file
  [
    (function_declaration
      (simple_identifier) @AlabasterDefinition)
    (class_declaration
      (type_identifier) @AlabasterDefinition)
    (object_declaration
      (type_identifier) @AlabasterDefinition)
    (type_alias
      (type_identifier) @AlabasterDefinition)
  ])

; Class, interface, object, and companion-object members.
(class_body
  [
    (function_declaration
      (simple_identifier) @AlabasterDefinition)
    (class_declaration
      (type_identifier) @AlabasterDefinition)
    (object_declaration
      (type_identifier) @AlabasterDefinition)
    (companion_object
      (type_identifier) @AlabasterDefinition)
    (type_alias
      (type_identifier) @AlabasterDefinition)
  ])

(enum_class_body
  [
    (function_declaration
      (simple_identifier) @AlabasterDefinition)
    (class_declaration
      (type_identifier) @AlabasterDefinition)
    (object_declaration
      (type_identifier) @AlabasterDefinition)
  ])

; Module/member properties are definitions; statement-local properties are not.
((property_declaration
   (variable_declaration
     (simple_identifier) @AlabasterDefinition))
  (#not-has-ancestor? @AlabasterDefinition statements))

; `val`/`var` constructor parameters are properties; plain parameters are not.
(class_parameter
  (binding_pattern_kind)
  (simple_identifier) @AlabasterDefinition)

; `const` and enum entries are constants by grammar.
((property_declaration
   (modifiers
     (property_modifier) @_const)
   (variable_declaration
     (simple_identifier) @AlabasterConstant))
  (#eq? @_const "const")
  (#not-has-ancestor? @AlabasterConstant statements)
  (#set! priority 110))

(enum_entry
  (simple_identifier) @AlabasterConstant)

; Annotation names are references; only their delimiters are punctuation.
(annotation
  "@" @AlabasterPunct
  [
    (user_type
      (type_identifier) @AlabasterBase)
    (constructor_invocation
      (user_type
        (type_identifier) @AlabasterBase))
  ])

(file_annotation
  "@" @AlabasterPunct
  ":" @AlabasterPunct)

(shebang_line) @AlabasterHashbang
