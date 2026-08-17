return function(root, parser_path)
    local cases = {
        bash = {
            source = [[
declare GLOBAL=1
export EXPORTED=2
function public_fn() { local local_value=3; echo "$USE_ONLY"; }
]],
            expected = { definition = { "GLOBAL", "EXPORTED", "public_fn" }, constant = {} },
            forbidden = { definition = { "local_value", "USE_ONLY" }, constant = { "GLOBAL" } },
        },
        c = {
            source = [[
enum Mode { Ready };
struct Widget { int field; };
int global = 1;
void public_fn(void) { int local_value = 2; helper(); }
]],
            expected = {
                definition = { "Mode", "Widget", "field", "global", "public_fn" },
                constant = { "Ready" },
            },
            forbidden = { definition = { "local_value", "helper" }, constant = { "global" } },
        },
        c_sharp = {
            source = [[
namespace App {
  class Widget {
    const int Limit = 1;
    int field;
    void Run() { const int LocalLimit = 2; int localValue = 3; Helper(); }
  }
}
]],
            expected = {
                definition = { "App", "Widget", "field", "Run" },
                constant = { "Limit", "LocalLimit" },
            },
            forbidden = { definition = { "localValue", "Helper" }, constant = { "Widget" } },
        },
        clojure = {
            source = [[
(ns sample.core)
(def answer 42)
(defn public-fn [] (let [local-value 1] (helper local-value)))
:ready
]],
            expected = {
                definition = { "sample.core", "answer", "public-fn" },
                constant = { ":ready" },
            },
            forbidden = { definition = { "local-value", "helper" }, constant = { "answer" } },
        },
        commonlisp = {
            source = [[
(defun public-fn (arg) (let ((local-value 1)) (helper local-value)))
(defconstant +limit+ 3)
(defparameter *state* 4)
(print +use-only+)
(print '+symbol+)
]],
            expected = {
                definition = { "public-fn", "*state*" },
                constant = { "+limit+", "+symbol+" },
            },
            forbidden = {
                definition = { "local-value", "helper", "+limit+" },
                constant = { "+use-only+", "public-fn" },
            },
        },
        cpp = {
            source = [[
enum Mode { Ready };
struct Widget { int field; };
int global = 1;
void public_fn() { int local_value = 2; helper(); }
]],
            expected = {
                definition = { "Mode", "Widget", "field", "global", "public_fn" },
                constant = { "Ready" },
            },
            forbidden = { definition = { "local_value", "helper" }, constant = { "global" } },
        },
        elm = {
            source = [[
module Sample exposing (..)
type Msg = Ready | Data Int
globalValue = 1
publicFn x = let localValue = 2 in helper localValue
]],
            expected = {
                definition = { "Sample", "Msg", "globalValue", "publicFn" },
                constant = { "Ready", "Data" },
            },
            forbidden = { definition = { "localValue", "helper" }, constant = { "publicFn" } },
        },
        fennel = {
            source = [[
(global exported 1)
(fn public-fn [arg] (let [local-value 2] (helper local-value)))
(print :ready)
(print 'quoted)
]],
            expected = {
                definition = { "exported", "public-fn" },
                constant = { ":ready", "quoted" },
            },
            forbidden = { definition = { "local-value", "helper" }, constant = { "public-fn" } },
        },
        fish = {
            source = [[
function public_fn
  set -l local_value 1
  echo $USE_ONLY
end
set -g GLOBAL 2
set -x -U UNIVERSAL 3
set value -g fake
]],
            expected = { definition = { "public_fn", "GLOBAL", "UNIVERSAL" }, constant = {} },
            forbidden = {
                definition = { "local_value", "USE_ONLY", "fake" },
                constant = { "GLOBAL" },
            },
        },
        go = {
            source = [[
package sample
var Global = 1
const Limit = 2
type Widget int
func Public() { localValue := 3; Helper(localValue) }
]],
            expected = {
                definition = { "sample", "Global", "Widget", "Public" },
                constant = { "Limit" },
            },
            forbidden = { definition = { "localValue", "Helper" }, constant = { "Global" } },
        },
        hare = {
            source = [[
def LIMIT: int = 1;
type widget = struct { field: int };
let global: int = 2;
fn public_fn() void = { let local_value: int = 3; };
]],
            expected = {
                definition = { "widget", "field", "global", "public_fn" },
                constant = { "LIMIT" },
            },
            forbidden = { definition = { "local_value" }, constant = { "global" } },
        },
        java = {
            source = [[
package sample;
class Widget {
  int field;
  void run() { int localValue = 1; helper(); }
  class Nested {}
}
interface Config { int Limit = 1; }
enum Mode { Ready }
]],
            expected = {
                definition = { "sample", "Widget", "field", "run", "Nested", "Config", "Mode" },
                constant = { "Limit", "Ready" },
            },
            forbidden = { definition = { "localValue", "helper" }, constant = { "Widget" } },
        },
        javascript = {
            source = [[
export const globalValue = 1;
export function publicFn() { const localValue = 2; helper(localValue); }
class Widget { field = 1; method() { return useOnly; } }
]],
            expected = {
                definition = { "globalValue", "publicFn", "Widget", "field", "method" },
                constant = {},
            },
            forbidden = {
                definition = { "localValue", "helper", "useOnly" },
                constant = { "globalValue" },
            },
        },
        json = {
            source = [[{"key": "value", "enabled": true, "count": 1}]],
            expected = { definition = {}, constant = {} },
            forbidden = { definition = { "\"key\"", "\"value\"" }, constant = { "\"enabled\"" } },
        },
        kotlin = {
            source = [[
package sample
const val LIMIT = 1
val globalValue = 2
class Widget(val member: Int) {
  val field = 3
  fun method() { val localValue = 4; helper() }
}
enum class Mode { READY }
fun publicFn() = Unit
]],
            expected = {
                definition = { "sample", "globalValue", "Widget", "member", "field", "method", "Mode", "publicFn" },
                constant = { "LIMIT", "READY" },
            },
            forbidden = { definition = { "localValue", "helper" }, constant = { "globalValue" } },
        },
        lua = {
            source = [[
function public_fn() local local_value = 1; helper(local_value) end
local function hidden() end
local assigned
assigned = function() end
local M = {}
function M.api() end
function M:method_api() end
M.assigned_api = function() end
function outer()
    local inner = {}
    function inner.nested_api() end
    function inner:nested_method() end
    inner.nested_assigned = function() end
end
return { exported_api = function() end, value = 1 }
]],
            expected = {
                base = { "M" },
                definition = { "public_fn", "api", "method_api", "assigned_api", "outer", "exported_api" },
                constant = {},
            },
            forbidden = {
                base = {},
                definition = {
                    "M",
                    "local_value",
                    "helper",
                    "hidden",
                    "assigned",
                    "nested_api",
                    "nested_method",
                    "nested_assigned",
                    "value",
                },
                constant = { "M", "public_fn" },
            },
        },
        python = {
            source = [[
GLOBAL = 1
def public_fn():
    local_value = 2
    helper(local_value)
class Widget:
    field = 3
    def method(self):
        inner = 4
    class Nested:
        pass
__debug__
]],
            expected = {
                definition = { "GLOBAL", "public_fn", "Widget", "field", "method", "Nested" },
                constant = { "__debug__" },
            },
            forbidden = { definition = { "local_value", "helper", "inner" }, constant = { "GLOBAL" } },
        },
        ruby = {
            source = [[
LIMIT = 1
class Widget
  def method
    local_value = 2
    helper(local_value)
  end
end
def public_fn; end
puts Widget
:ready
]],
            expected = {
                definition = { "Widget", "method", "public_fn" },
                constant = { "LIMIT", "Widget", ":ready" },
            },
            forbidden = { definition = { "local_value", "helper" }, constant = { "local_value" } },
        },
        rust = {
            source = [[
const LIMIT: i32 = 1;
static STATE: i32 = 2;
struct Widget { field: i32 }
enum Mode { Ready }
fn public_fn() { let local_value = 3; helper(local_value); }
]],
            expected = {
                definition = { "Widget", "field", "Mode", "public_fn" },
                constant = { "LIMIT", "STATE", "Ready" },
            },
            forbidden = { definition = { "local_value", "helper" }, constant = { "local_value" } },
        },
        scala = {
            source = [[
package sample
val globalValue = 1
class Widget(val member: Int):
  val field = 2
  def method(): Unit =
    val localValue = 3
enum Mode:
  case Ready
  case Data(value: Int)
def publicFn() = helper()
]],
            expected = {
                definition = { "sample", "globalValue", "Widget", "member", "field", "method", "Mode", "value", "publicFn" },
                constant = { "Ready", "Data" },
            },
            forbidden = { definition = { "localValue", "helper", "Data" }, constant = { "globalValue" } },
        },
        typescript = {
            source = [[
namespace Api { export const inside = 1; export function exposed() { const localValue = 2; helper(); } }
export interface Shape { size: number; area(): number }
export enum Mode { Ready }
export class Widget { field = 1; method() { let inner = 2; } }
export const globalValue = 1;
]],
            expected = {
                definition = { "Api", "inside", "exposed", "Shape", "size", "area", "Mode", "Widget", "field", "method", "globalValue" },
                constant = { "Ready" },
            },
            forbidden = { definition = { "localValue", "helper", "inner" }, constant = { "globalValue" } },
        },
        vim = {
            source = [[
function! Public()
  let l:local_value = v:null
  call Helper()
endfunction
function! s:Script()
endfunction
command! MyCommand echo "x"
highlight MyGroup guifg=#ffffff
highlight link LinkFrom LinkTo
]],
            expected = {
                definition = { "Public", "Script", "MyCommand", "MyGroup", "LinkFrom" },
                constant = { "null" },
            },
            forbidden = { definition = { "local_value", "Helper", "LinkTo" }, constant = { "Public" } },
        },
        zig = {
            source = [[
const LIMIT = 1;
var global = 2;
const Widget = struct {
    field: i32,
    const INNER = 3;
    fn method() void { const local_value = 4; helper(); }
};
fn public_fn() void {}
const std = @import("std");
]],
            expected = {
                definition = { "global", "Widget", "field", "method", "public_fn", "std" },
                constant = { "LIMIT", "INNER" },
            },
            forbidden = { definition = { "local_value", "helper" }, constant = { "local_value" } },
        },
    }

    local function fallback_query(language)
        local path = vim.fs.joinpath(root, "after", "queries", language, "highlights.scm")
        return vim.treesitter.query.parse(language, table.concat(vim.fn.readfile(path), "\n"))
    end

    local function semantic_query(language)
        local custom_path = vim.fs.normalize(vim.fn.fnamemodify(
            vim.fs.joinpath(root, "after", "queries", language, "highlights.scm"),
            ":p"
        ))
        local has_base = false
        for _, path in ipairs(vim.api.nvim_get_runtime_file("queries/" .. language .. "/highlights.scm", true)) do
            if vim.fs.normalize(path) ~= custom_path then
                has_base = true
                break
            end
        end

        if has_base then
            local ok, query = pcall(vim.treesitter.query.get, language, "highlights")
            assert(ok, ("%s: merged query failed: %s"):format(language, query))
            assert(query, language .. ": merged highlights query is missing")
            return query, true
        end
        return fallback_query(language), false
    end

    local function semantic_kind(capture)
        local alabaster = {
            AlabasterBase = "base",
            AlabasterDefinition = "definition",
            AlabasterConstant = "constant",
        }
        if alabaster[capture] then return alabaster[capture] end
        if capture == "constant" or capture:match("^constant%.") then return "constant" end
    end

    local checked, skipped, merged, failures = 0, 0, 0, {}
    for language, case in pairs(cases) do
        local path = parser_path(language)
        if not path then
            skipped = skipped + 1
        else
            vim.treesitter.language.add(language, { path = path })
            local tree = assert(vim.treesitter.get_string_parser(case.source, language)):parse()[1]
            local query, is_merged = semantic_query(language)
            if is_merged then merged = merged + 1 end
            local captures = { base = {}, definition = {}, constant = {} }
            local tokens = {}

            for id, node in query:iter_captures(tree:root(), case.source, 0, -1) do
                local kind = semantic_kind(query.captures[id])
                if kind then
                    local row, column, end_row, end_column = node:range()
                    local key = table.concat({ row, column, end_row, end_column }, ":")
                    tokens[key] = { kind = kind, text = vim.treesitter.get_node_text(node, case.source) }
                end
            end
            for _, token in pairs(tokens) do
                captures[token.kind][token.text] = true
            end

            for kind, names in pairs(case.expected) do
                for _, name in ipairs(names) do
                    if not captures[kind][name] then
                        failures[#failures + 1] = ("%s: missing %s capture for %q"):format(language, kind, name)
                    end
                end
            end
            for kind, names in pairs(case.forbidden) do
                for _, name in ipairs(names) do
                    if captures[kind][name] then
                        failures[#failures + 1] = ("%s: forbidden %s capture for %q"):format(language, kind, name)
                    end
                end
            end
            checked = checked + 1
        end
    end

    print(("query semantics: %d checked, %d merged, %d skipped"):format(checked, merged, skipped))
    assert(#failures == 0, table.concat(failures, "\n"))
end
