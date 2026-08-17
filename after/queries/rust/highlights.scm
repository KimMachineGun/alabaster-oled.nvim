;; vim: ft=query
;; extends

; Reset heuristic identifier coloring; declarations below add reliable semantics.
(identifier) @AlabasterBase
(field_identifier) @AlabasterBase

; Module declarations and structural members, but never lexical definitions.
([
  (function_item name: (identifier) @AlabasterDefinition)
  (function_signature_item name: (identifier) @AlabasterDefinition)
  (struct_item name: (type_identifier) @AlabasterDefinition)
  (union_item name: (type_identifier) @AlabasterDefinition)
  (enum_item name: (type_identifier) @AlabasterDefinition)
  (trait_item name: (type_identifier) @AlabasterDefinition)
  (type_item name: (type_identifier) @AlabasterDefinition)
  (associated_type name: (type_identifier) @AlabasterDefinition)
  (mod_item name: (identifier) @AlabasterDefinition)
  (macro_definition name: (identifier) @AlabasterDefinition)
  (field_declaration name: (field_identifier) @AlabasterDefinition)
 ]
  (#not-has-ancestor? @AlabasterDefinition block))

; Constants are likewise semantic only outside lexical blocks.
([
  (const_item name: (identifier) @AlabasterConstant)
  (static_item name: (identifier) @AlabasterConstant)
  (enum_variant name: (identifier) @AlabasterConstant)
 ]
  (#not-has-ancestor? @AlabasterConstant block))
