local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fs.dirname(vim.fs.dirname(source))
vim.opt.runtimepath:prepend(root)
vim.opt.runtimepath:append(vim.fs.joinpath(root, "after"))

for _, path in ipairs(vim.fn.globpath(vim.o.packpath, "pack/*/opt/nvim-treesitter/runtime", false, true)) do
    vim.opt.runtimepath:prepend(path)
end

local parser_dirs = {
    vim.fs.joinpath(vim.fn.stdpath("data"), "site", "parser"),
    vim.fn.expand("~/.local/share/nvim-pack/site/parser"),
    vim.fn.expand("~/.local/share/nvim/site/parser"),
}
if vim.env.ALABASTER_PARSER_DIR and vim.env.ALABASTER_PARSER_DIR ~= "" then
    table.insert(parser_dirs, 1, vim.env.ALABASTER_PARSER_DIR)
    vim.opt.runtimepath:prepend(vim.fs.dirname(vim.env.ALABASTER_PARSER_DIR))
end

local function parser_path(language)
    for _, directory in ipairs(parser_dirs) do
        if directory and directory ~= "" then
            local path = vim.fs.joinpath(directory, language .. ".so")
            if vim.uv.fs_stat(path) then return path end
        end
    end
end

local query_root = vim.fs.joinpath(root, "after", "queries")
for _, language in ipairs(vim.fn.readdir(query_root)) do
    local path = parser_path(language)
    if path then
        vim.treesitter.language.add(language, { path = path })
        local query_path = vim.fs.joinpath(query_root, language, "highlights.scm")
        vim.treesitter.query.parse(language, table.concat(vim.fn.readfile(query_path), "\n"))
    end
end

dofile(vim.fs.joinpath(root, "tests", "query_semantics.lua"))(root, parser_path)

local function highlight(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function assert_color(name, key, expected)
    local actual = highlight(name)[key]
    assert(actual == tonumber(expected:sub(2), 16), ("%s.%s: expected %s, got %s"):format(
        name,
        key,
        expected,
        actual and ("#%06X"):format(actual) or "NONE"
    ))
end

local function assert_link(name, expected)
    local actual = vim.api.nvim_get_hl(0, { name = name, link = true }).link
    assert(actual == expected, ("%s: expected link %s, got %s"):format(name, expected, tostring(actual)))
end

vim.cmd.colorscheme("alabaster-oled")

assert(vim.g.colors_name == "alabaster-oled")
assert_color("Normal", "bg", "#000000")
assert_color("Comment", "fg", "#DFDF8E")
assert_color("Comment", "bg", "#292815")
assert_color("Special", "fg", "#708B8D")
assert_color("SpecialKey", "fg", "#708B8D")
assert_color("SpecialChar", "fg", "#CC8BC9")
assert(next(highlight("@lsp.type.function")) == nil, "LSP functions should defer to Tree-sitter")
assert(next(highlight("@lsp.type.variable")) == nil, "LSP variables should defer to Tree-sitter")
assert(next(highlight("@lsp.type.namespace.go")) == nil, "Go namespace LSP highlighting should be disabled")
assert(next(highlight("@lsp.type.variable.go")) == nil, "Go variable LSP highlighting should be disabled")
assert_link("@lsp.type.enumMember", "AlabasterConstant")
assert_link("@lsp.type.macro", "AlabasterConstant")
assert_link("@lsp.typemod.variable.readonly.go", "AlabasterConstant")

local terminal = {
    "#000000",
    "#C0696A",
    "#90BF86",
    "#CD974B",
    "#74A7D5",
    "#BB8DBE",
    "#52B5A4",
    "#CECECE",
    "#708B8D",
    "#F07178",
    "#B0E39D",
    "#DFDF8E",
    "#8FC5F4",
    "#E2A6DE",
    "#6FD5C0",
    "#FFFFFF",
}

for index, expected in ipairs(terminal) do
    local name = "terminal_color_" .. (index - 1)
    assert(vim.g[name] == expected, ("%s: expected %s, got %s"):format(name, expected, tostring(vim.g[name])))
end

local go_parser = parser_path("go")
if go_parser then
    vim.treesitter.language.add("go", { path = go_parser })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
        "package sample",
        "var Single = nil",
        "var (",
        "    Grouped = true",
        ")",
        "type Widget struct{}",
        "func main() {}",
    })

    local tree = assert(vim.treesitter.get_parser(0, "go")):parse(true)[1]
    local query_path = vim.fs.joinpath(root, "after", "queries", "go", "highlights.scm")
    local query = vim.treesitter.query.parse("go", table.concat(vim.fn.readfile(query_path), "\n"))
    local definitions = {}
    for id, node in query:iter_captures(tree:root(), 0, 0, -1) do
        if query.captures[id] == "AlabasterDefinition" then
            definitions[vim.treesitter.get_node_text(node, 0)] = true
        end
    end
    for _, name in ipairs({ "sample", "Single", "Grouped", "Widget", "main" }) do
        assert(definitions[name], "missing Go definition capture: " .. name)
    end
end

vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "font_family MonoLisaCode",
    "font_size 8.0",
    "# Comment",
    "map --allow-fallback=shifted,ascii kitty_mod+w close_window_with_confirmation",
    "map alt+space>enter toggle_layout stack",
})
vim.bo.modified = false
vim.cmd("syntax enable")
vim.bo.syntax = "kitty"

assert_link("kittyOptionName", "AlabasterBase")
assert_link("kittyMapName", "AlabasterBase")
assert_link("kittyString", "AlabasterBase")
assert_link("kittyKey", "AlabasterConstant")
assert_link("kittyParameter", "AlabasterPunct")
assert_link("kittyMapFlag", "AlabasterPunct")
assert_link("kittyComment", "Comment")

local flag_id = vim.fn.synID(4, 5, true)
assert(vim.fn.synIDattr(flag_id, "name") == "kittyMapFlag", "map flag syntax correction did not apply")

vim.cmd.colorscheme("default")
assert_link("kittyKey", "Special")
assert_link("kittyMapName", "Function")
assert_link("kittyMapFlag", "Special")
vim.cmd.colorscheme("alabaster-oled")
assert_link("kittyKey", "AlabasterConstant")
assert_color("Special", "fg", "#708B8D")

print("alabaster-oled smoke test passed")
