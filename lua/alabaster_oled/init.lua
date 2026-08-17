local M = {}

M.palette = require("alabaster_oled.palette")

local kitty_highlights = {
    kittyOptionName = { link = "AlabasterBase" },
    kittyModName = { link = "AlabasterBase" },
    kittyMapName = { link = "AlabasterBase" },
    kittyMouseMapName = { link = "AlabasterBase" },
    kittyString = { link = "AlabasterBase" },
    kittyNumber = { link = "AlabasterConstant" },
    kittyAlpha = { link = "AlabasterConstant" },
    kittyColor = { link = "AlabasterConstant" },
    kittyBoolean = { link = "AlabasterConstant" },
    kittyConstant = { link = "AlabasterConstant" },
    kittyKey = { link = "AlabasterConstant" },
    kittyCtrl = { link = "AlabasterConstant" },
    kittyAlt = { link = "AlabasterConstant" },
    kittyShift = { link = "AlabasterConstant" },
    kittySuper = { link = "AlabasterConstant" },
    kittyMouseMapType = { link = "AlabasterConstant" },
    kittyMouseMapGrabbed = { link = "AlabasterConstant" },
    kittyFlag = { link = "AlabasterPunct" },
    kittyParameter = { link = "AlabasterPunct" },
    kittyMapFlag = { link = "AlabasterPunct" },
    kittyAnd = { link = "AlabasterPunct" },
    kittyWith = { link = "AlabasterPunct" },
    kittyLineContinue = { link = "AlabasterPunct" },
    kittyComment = { link = "Comment" },
}

local function set_highlights(highlights)
    for group, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, highlight)
    end
end

local function set_terminal_colors(palette)
    for index, color in ipairs(palette.terminal) do
        vim.g["terminal_color_" .. (index - 1)] = color
    end
end

function M.apply()
    local palette = M.palette

    set_terminal_colors(palette)

    local highlights = {
        -- Canonical semantic groups used by language queries and legacy syntax adapters.
        AlabasterBase = { fg = palette.fg },
        AlabasterString = { fg = palette.string },
        AlabasterConstant = { fg = palette.constant },
        AlabasterDefinition = { fg = palette.definition },
        AlabasterPunct = { fg = palette.muted },

        -- OLED surfaces
        Normal = { fg = palette.fg, bg = palette.bg },
        NormalNC = { fg = palette.fg, bg = palette.bg },
        NormalFloat = { fg = palette.fg, bg = palette.surface },
        FloatBorder = { fg = palette.muted, bg = palette.surface },
        SignColumn = { bg = palette.bg },
        FoldColumn = { fg = palette.muted, bg = palette.bg },
        Folded = { fg = palette.muted, bg = palette.surface },
        WinBar = { fg = palette.fg, bg = palette.bg, bold = false },
        WinBarNC = { fg = palette.muted, bg = palette.bg, bold = false },
        CursorLine = { bg = palette.surface },
        CursorColumn = { bg = palette.surface },
        ColorColumn = { bg = palette.surface },
        LineNr = { fg = palette.muted, bg = palette.bg },
        CursorLineNr = { fg = palette.definition, bg = palette.surface, bold = false },
        Pmenu = { fg = palette.fg, bg = palette.surface },
        PmenuSel = { fg = palette.fg, bg = palette.selection },
        PmenuSbar = { bg = palette.surface },
        PmenuThumb = { bg = palette.muted },
        StatusLine = { fg = palette.fg, bg = palette.surface_alt },
        StatusLineNC = { fg = palette.muted, bg = palette.surface },
        TabLine = { fg = palette.muted, bg = palette.surface },
        TabLineFill = { bg = palette.surface },
        TabLineSel = { fg = palette.fg, bg = palette.bg },
        Visual = { bg = palette.selection },
        VisualNOS = { bg = palette.selection },
        Search = { fg = palette.bg, bg = palette.active },
        IncSearch = { fg = palette.bg, bg = palette.comment },
        MatchParen = { fg = palette.comment, bg = palette.comment_bg, underline = true },

        -- Alabaster semantics
        Comment = { fg = palette.comment, bg = palette.comment_bg, bold = false, italic = false },
        SpecialComment = { link = "Comment" },
        String = { fg = palette.string },
        Character = { fg = palette.constant },
        Constant = { fg = palette.constant },
        Number = { fg = palette.constant },
        Boolean = { fg = palette.constant },
        Float = { fg = palette.constant },
        Function = { fg = palette.definition },
        Operator = { link = "AlabasterPunct" },
        Delimiter = { link = "AlabasterPunct" },
        Special = { link = "AlabasterPunct" },
        SpecialKey = { link = "AlabasterPunct" },
        SpecialChar = { link = "AlabasterConstant" },
        Keyword = { fg = palette.fg, bold = false, italic = false },
        Statement = { fg = palette.fg, bold = false, italic = false },
        Type = { fg = palette.fg, bold = false, italic = false },

        -- Tree-sitter and Alabaster's language-specific definition captures
        ["@comment"] = { link = "Comment" },
        ["@comment.documentation"] = { link = "Comment" },
        ["@string"] = { fg = palette.string },
        ["@string.escape"] = { fg = palette.constant },
        ["@constant"] = { fg = palette.constant },
        ["@constant.builtin"] = { fg = palette.constant },
        ["@number"] = { fg = palette.constant },
        ["@boolean"] = { fg = palette.constant },
        ["@function"] = { fg = palette.fg },
        ["@function.call"] = { fg = palette.fg },
        ["@function.method.call"] = { fg = palette.fg },
        ["@function.builtin"] = { link = "AlabasterBase" },
        ["@constructor"] = { link = "AlabasterBase" },
        ["@variable.parameter.builtin"] = { link = "AlabasterBase" },
        ["@attribute.builtin"] = { link = "AlabasterBase" },
        ["@tag.builtin"] = { link = "AlabasterBase" },
        ["@character.special"] = { link = "AlabasterConstant" },
        ["@string.special"] = { link = "AlabasterConstant" },
        ["@method.call"] = { fg = palette.fg },
        ["@keyword"] = { fg = palette.fg, bold = false, italic = false },
        ["@operator"] = { fg = palette.muted },
        ["@punctuation.delimiter"] = { fg = palette.muted },
        ["@punctuation.bracket"] = { fg = palette.muted },
        ["@AlabasterBase"] = { link = "AlabasterBase" },
        ["@AlabasterConstant"] = { link = "AlabasterConstant" },
        ["@AlabasterDefinition"] = { link = "AlabasterDefinition" },
        ["@AlabasterPunct"] = { link = "AlabasterPunct" },
        ["@AlabasterString"] = { link = "AlabasterString" },
        ["@AlabasterHashbang"] = { fg = palette.muted },

        -- LSP semantic tokens have higher priority than Tree-sitter. Leave
        -- dual-role symbols empty so language queries can distinguish their
        -- declarations from uses; keep only parser-independent constants.
        ["@lsp.type.comment"] = { link = "Comment" },
        ["@lsp.type.class"] = {},
        ["@lsp.type.enum"] = {},
        ["@lsp.type.function"] = {},
        ["@lsp.type.interface"] = {},
        ["@lsp.type.method"] = {},
        ["@lsp.type.namespace"] = {},
        ["@lsp.type.property"] = {},
        ["@lsp.type.struct"] = {},
        ["@lsp.type.type"] = {},
        ["@lsp.type.variable"] = {},
        ["@lsp.mod.declaration"] = {},
        ["@lsp.typemod.class.declaration"] = {},
        ["@lsp.typemod.class.definition"] = {},
        ["@lsp.typemod.enum.declaration"] = {},
        ["@lsp.typemod.function.declaration"] = {},
        ["@lsp.typemod.function.definition"] = {},
        ["@lsp.typemod.macro.declaration"] = {},
        ["@lsp.typemod.method.declaration"] = {},
        ["@lsp.typemod.struct.declaration"] = {},
        ["@lsp.typemod.type.declaration"] = {},
        ["@lsp.type.const"] = { link = "AlabasterConstant" },
        ["@lsp.type.enumMember"] = { link = "AlabasterConstant" },
        ["@lsp.type.macro"] = { link = "AlabasterConstant" },
        ["@lsp.typemod.variable.readonly.go"] = { link = "AlabasterConstant" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "AlabasterConstant" },

        -- Comment annotations keep the background model but carry urgency.
        Todo = { fg = palette.bg, bg = palette.comment, bold = false },
        ["@comment.todo"] = { link = "Todo" },
        ["@comment.note"] = { fg = palette.bg, bg = palette.definition, bold = false },
        ["@comment.warning"] = { fg = palette.bg, bg = palette.active, bold = false },
        ["@comment.error"] = { fg = palette.bg, bg = palette.red, bold = false },

        -- Diagnostics remain distinct without turning normal code into confetti.
        DiagnosticError = { fg = palette.red },
        DiagnosticWarn = { fg = palette.active },
        DiagnosticInfo = { fg = palette.definition },
        DiagnosticHint = { fg = palette.diagnostic_hint },
        DiagnosticUnderlineError = { undercurl = true, sp = palette.red },
        DiagnosticUnderlineWarn = { undercurl = true, sp = palette.active },
    }

    set_highlights(highlights)
    M.apply_kitty()
end

-- The bundled Kitty syntax loads after colorschemes and force-links its groups.
-- Reapply only this adapter from after/syntax when alabaster-oled is active.
function M.apply_kitty()
    set_highlights(kitty_highlights)
end

return M
