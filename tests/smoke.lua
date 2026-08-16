local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fs.dirname(vim.fs.dirname(source))
vim.opt.runtimepath:prepend(root)
vim.opt.runtimepath:append(vim.fs.joinpath(root, "after"))

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
assert(next(highlight("@lsp.type.namespace.go")) == nil, "Go namespace LSP highlighting should be disabled")

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
