;; extends

((source
   (list_lit
     .
     (sym_lit) @_definition
     .
     (sym_lit
       name: (sym_name) @AlabasterDefinition)))
 (#any-of? @_definition
   "def"
   "definline"
   "definterface"
   "defmacro"
   "defmulti"
   "defn"
   "defn-"
   "defonce"
   "defprotocol"
   "defrecord"
   "defstruct"
   "deftype"
   "ns"))

((source
   (list_lit
     .
     (sym_lit) @_declare
     (sym_lit
       name: (sym_name) @AlabasterDefinition)))
 (#eq? @_declare "declare"))

(kwd_lit) @AlabasterConstant
