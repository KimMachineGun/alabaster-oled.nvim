;; vim: ft=query
;; extends

(variable_name) @AlabasterBase

(program
  (function_definition
    name: (word) @AlabasterDefinition))

(program
  (declaration_command
    [
      "declare"
      "export"
      "readonly"
      "typeset"
    ]
    [
      (variable_name) @AlabasterDefinition
      (variable_assignment
        name: (variable_name) @AlabasterDefinition)
    ]))

((declaration_command
   [
     "declare"
     "typeset"
   ]
   (word) @_global
   [
     (variable_name) @AlabasterDefinition
     (variable_assignment
       name: (variable_name) @AlabasterDefinition)
   ])
 (#lua-match? @_global "^%-[^%-]*g"))

((declaration_command
   [
     "declare"
     "typeset"
   ]
   (word) @_global
   [
     (variable_name) @AlabasterDefinition
     (variable_assignment
       name: (variable_name) @AlabasterDefinition)
   ])
 (#eq? @_global "--global"))

((program . (comment) @AlabasterHashbang)
 (#match? @AlabasterHashbang "^#!/"))
