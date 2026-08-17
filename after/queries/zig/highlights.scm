;; vim: ft=query
;; extends

; Reset naming heuristics; declarations below add reliable semantics.
(identifier) @AlabasterBase

; Module declarations and structural members, but never lexical definitions.
((function_declaration
   name: (identifier) @AlabasterDefinition)
  (#not-has-ancestor? @AlabasterDefinition block))

; Container fields are definitions, except enum entries which are constants.
([
  (struct_declaration
    (container_field name: (identifier) @AlabasterDefinition))
  (union_declaration
    (container_field name: (identifier) @AlabasterDefinition))
 ]
  (#not-has-ancestor? @AlabasterDefinition block))

((enum_declaration
   (container_field name: (identifier) @AlabasterConstant))
  (#not-has-ancestor? @AlabasterConstant block))

; Module/container vars are statics. Local block declarations are excluded.
((variable_declaration
   "var"
   (identifier) @AlabasterDefinition)
  (#not-has-ancestor? @AlabasterDefinition block))

; Module/container consts are constants; later, more specific definitions win.
((variable_declaration
   "const"
   (identifier) @AlabasterConstant)
  (#not-has-ancestor? @AlabasterConstant block))

; Container types are definitions rather than constants.
((variable_declaration
   (identifier) @AlabasterDefinition
   "="
   [(struct_declaration) (union_declaration) (enum_declaration) (opaque_declaration)])
  (#not-has-ancestor? @AlabasterDefinition block)
  (#set! priority 110))

; Imported module bindings are also definitions.
((variable_declaration
   (identifier) @AlabasterDefinition
   (builtin_function (builtin_identifier) @_import))
  (#any-of? @_import "@import" "@cImport")
  (#not-has-ancestor? @AlabasterDefinition block)
  (#set! priority 110))
