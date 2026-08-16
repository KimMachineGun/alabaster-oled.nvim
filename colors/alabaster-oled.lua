vim.o.background = "dark"
vim.g.alabaster_dim_comments = false
vim.g.alabaster_floatborder = true

-- A :colorscheme command cannot recursively load another colorscheme reliably.
-- Execute the vendored upstream file directly, then apply the OLED delta.
local source = debug.getinfo(1, "S").source:sub(2)
local colors_dir = vim.fs.dirname(source)
dofile(vim.fs.joinpath(colors_dir, "alabaster.lua"))

require("alabaster_oled").apply()

vim.g.colors_name = "alabaster-oled"
