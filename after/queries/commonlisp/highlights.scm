;; vim: ft=query
;; extends

; `+name+` is only a convention, so references stay neutral.
((sym_lit) @AlabasterBase
  (#lua-match? @AlabasterBase "^[+].+[+]$"))

(defun
  (defun_header
    function_name: (sym_lit) @AlabasterDefinition))

((source
   (list_lit
     .
     (sym_lit) @_definition
     .
     [
       (kwd_lit) @AlabasterDefinition
       (sym_lit) @AlabasterDefinition
     ]))
 (#any-of? @_definition
   "defclass"
   "defpackage"
   "defparameter"
   "defstruct"
   "deftype"
   "defvar"
   "define-condition"))

((source
   (list_lit
     .
     (sym_lit) @_definition
     .
     [
       (kwd_lit) @AlabasterConstant
       (sym_lit) @AlabasterConstant
     ]))
 (#eq? @_definition "defconstant"))

(quoting_lit
  value: (sym_lit) @AlabasterConstant)
