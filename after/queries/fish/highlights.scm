;; vim: ft=query
;; extends

(variable_expansion) @AlabasterBase

(program
  (function_definition
    name: (word) @AlabasterDefinition))

((command
   name: (word) @_set
   .
   argument: (word) @_scope
   .
   argument: (word) @AlabasterDefinition)
 (#eq? @_set "set")
 (#match? @_scope "\\v^(-[^eqnSu-]*[gU][^eqnSu-]*|--global|--universal)$")
 (#lua-match? @AlabasterDefinition "^[^%-]"))

((command
   name: (word) @_set
   .
   argument: (word) @_scope
   .
   argument: (word) @_option
   .
   argument: (word) @AlabasterDefinition)
 (#eq? @_set "set")
 (#match? @_scope "\\v^(-[^eqnSu-]*[gU][^eqnSu-]*|--global|--universal)$")
 (#any-of? @_option "-a" "-p" "-P" "-x" "--append" "--export" "--path" "--prepend")
 (#lua-match? @AlabasterDefinition "^[^%-]"))

((command
   name: (word) @_set
   .
   argument: (word) @_option
   .
   argument: (word) @_scope
   .
   argument: (word) @AlabasterDefinition)
 (#eq? @_set "set")
 (#any-of? @_option "-a" "-p" "-P" "-x" "--append" "--export" "--path" "--prepend")
 (#match? @_scope "\\v^(-[^eqnSu-]*[gU][^eqnSu-]*|--global|--universal)$")
 (#lua-match? @AlabasterDefinition "^[^%-]"))

((program . (comment) @AlabasterHashbang)
 (#match? @AlabasterHashbang "^#!/"))
