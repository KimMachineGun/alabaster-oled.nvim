local palette = {
    bg = "#000000",
    surface = "#080B0C",
    surface_alt = "#111719",
    selection = "#293334",
    fg = "#CECECE",
    muted = "#708B8D",
    comment = "#DFDF8E",
    comment_bg = "#292815",
    string = "#95CB82",
    constant = "#CC8BC9",
    definition = "#71ADE7",
    active = "#CD974B",
    red = "#F07178",
    diagnostic_hint = "#47BEA9",
}

-- Alabaster's terminal palette keeps normal ANSI colors restrained and uses
-- the semantic syntax accents only for their bright variants.
palette.terminal = {
    palette.bg,
    "#C0696A",
    "#90BF86",
    "#CD974B",
    "#74A7D5",
    "#BB8DBE",
    "#52B5A4",
    palette.fg,
    palette.muted,
    palette.red,
    "#B0E39D",
    palette.comment,
    "#8FC5F4",
    "#E2A6DE",
    "#6FD5C0",
    "#FFFFFF",
}

return palette
