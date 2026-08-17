;; vim: ft=query
;; extends

(constant) @AlabasterConstant

[
  (bare_symbol)
  (simple_symbol)
  (hash_key_symbol)
  (delimited_symbol)
] @AlabasterConstant

((method
  name: [
    (identifier) @AlabasterDefinition
    (constant) @AlabasterDefinition
    (setter
      name: (identifier) @AlabasterDefinition)
    (operator) @AlabasterDefinition
  ]) @_definition
  (#not-has-ancestor? @_definition method))

((singleton_method
  name: [
    (identifier) @AlabasterDefinition
    (constant) @AlabasterDefinition
    (setter
      name: (identifier) @AlabasterDefinition)
    (operator) @AlabasterDefinition
  ]) @_definition
  (#not-has-ancestor? @_definition method))

((alias
  name: (_) @AlabasterDefinition) @_definition
  (#not-has-ancestor? @_definition method))

((class
  name: [
    (constant) @AlabasterDefinition
    (scope_resolution
      name: (constant) @AlabasterDefinition)
  ]) @_definition
  (#not-has-ancestor? @_definition method))

((module
  name: [
    (constant) @AlabasterDefinition
    (scope_resolution
      name: (constant) @AlabasterDefinition)
  ]) @_definition
  (#not-has-ancestor? @_definition method))

((method
  name: (_) @AlabasterBase) @_definition
  (#has-ancestor? @_definition method))

((singleton_method
  name: (_) @AlabasterBase) @_definition
  (#has-ancestor? @_definition method))

((alias
  name: (_) @AlabasterBase) @_definition
  (#has-ancestor? @_definition method))

((class
  name: [
    (constant) @AlabasterBase
    (scope_resolution
      name: (constant) @AlabasterBase)
  ]) @_definition
  (#has-ancestor? @_definition method))

((module
  name: [
    (constant) @AlabasterBase
    (scope_resolution
      name: (constant) @AlabasterBase)
  ]) @_definition
  (#has-ancestor? @_definition method))
