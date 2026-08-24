vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "ryoku"

local colors = {
    bg = "#000000",
    bg_alt = "#0d0f0d",
    surface = "#151815",

    fg = "#cdc4ba",
    fg_bright = "#eee7df",
    fg_dim = "#8f8982",

    green = "#3f8f71",
    green_bright = "#65b88f",
    green_dark = "#1b3127",

    red = "#c66f6f",
    red_bright = "#df8a8a",

    yellow = "#b59b65",
    yellow_bright = "#d0b77a",

    blue = "#6f91a8",
    blue_bright = "#8eabc0",

    magenta = "#987aa1",
    magenta_bright = "#b194ba",

    cyan = "#5a9791",
    cyan_bright = "#77b6ae",
}

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi("Normal", { fg = colors.fg, bg = colors.bg })
hi("NormalNC", { fg = colors.fg, bg = colors.bg })
hi("NormalFloat", { fg = colors.fg, bg = colors.bg_alt })
hi("FloatBorder", { fg = colors.green, bg = colors.bg_alt })
hi("CursorLine", { bg = colors.bg_alt })
hi("CursorLineNr", { fg = colors.green_bright, bold = true })
hi("LineNr", { fg = colors.fg_dim })
hi("SignColumn", { bg = colors.bg })
hi("Visual", { bg = colors.green_dark })
hi("Search", { fg = colors.bg, bg = colors.yellow })
hi("IncSearch", { fg = colors.bg, bg = colors.green_bright })
hi("MatchParen", { fg = colors.green_bright, bold = true })
hi("StatusLine", { fg = colors.fg, bg = colors.surface })
hi("StatusLineNC", { fg = colors.fg_dim, bg = colors.bg_alt })
hi("WinSeparator", { fg = colors.surface })
hi("Pmenu", { fg = colors.fg, bg = colors.bg_alt })
hi("PmenuSel", { fg = colors.fg_bright, bg = colors.green_dark })
hi("PmenuSbar", { bg = colors.surface })
hi("PmenuThumb", { bg = colors.green })

-- Syntax
hi("Comment", { fg = colors.fg_dim, italic = true })
hi("Constant", { fg = colors.yellow })
hi("String", { fg = colors.green })
hi("Character", { fg = colors.green })
hi("Number", { fg = colors.yellow })
hi("Boolean", { fg = colors.yellow_bright })
hi("Identifier", { fg = colors.fg })
hi("Function", { fg = colors.green_bright })
hi("Statement", { fg = colors.blue })
hi("Conditional", { fg = colors.blue })
hi("Repeat", { fg = colors.blue })
hi("Operator", { fg = colors.fg })
hi("Keyword", { fg = colors.blue })
hi("Type", { fg = colors.cyan })
hi("Special", { fg = colors.magenta })
hi("PreProc", { fg = colors.magenta })

-- Diagnostics
hi("DiagnosticError", { fg = colors.red })
hi("DiagnosticWarn", { fg = colors.yellow })
hi("DiagnosticInfo", { fg = colors.blue })
hi("DiagnosticHint", { fg = colors.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = colors.green })

-- Git
hi("DiffAdd", { fg = colors.green, bg = colors.bg })
hi("DiffChange", { fg = colors.yellow, bg = colors.bg })
hi("DiffDelete", { fg = colors.red, bg = colors.bg })

-- Tree-sitter
hi("@comment", { fg = colors.fg_dim, italic = true })
hi("@string", { fg = colors.green })
hi("@string.escape", { fg = colors.cyan })
hi("@number", { fg = colors.yellow })
hi("@boolean", { fg = colors.yellow_bright })
hi("@constant", { fg = colors.yellow })
hi("@variable", { fg = colors.fg })
hi("@variable.parameter", { fg = colors.fg_bright })
hi("@function", { fg = colors.green_bright })
hi("@function.call", { fg = colors.green })
hi("@keyword", { fg = colors.blue })
hi("@keyword.function", { fg = colors.blue })
hi("@type", { fg = colors.cyan })
hi("@operator", { fg = colors.fg })
hi("@punctuation", { fg = colors.fg_dim })
hi("@markup.heading", { fg = colors.green_bright, bold = true })
hi("@markup.link", { fg = colors.blue })
hi("@markup.raw", { fg = colors.green })

-- Plugins
hi("NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
hi("NvimTreeFolderName", { fg = colors.green })
hi("NvimTreeOpenedFolderName", { fg = colors.green_bright, bold = true })
hi("NvimTreeRootFolder", { fg = colors.fg_dim })
hi("GitSignsAdd", { fg = colors.green })
hi("GitSignsChange", { fg = colors.yellow })
hi("GitSignsDelete", { fg = colors.red })
