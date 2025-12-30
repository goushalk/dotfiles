vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "foresttrail"

local hl = vim.api.nvim_set_hl

-- Core
hl(0, "Normal", { bg = "none" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "SignColumn", { bg = "none" })
hl(0, "Comment", { fg = "#bbf2bd", italic = true })
hl(0, "LineNr", { fg = "#3f5f55" })
hl(0, "CursorLineNr", { fg = "#c7b38c", bold = true })

-- Syntax
hl(0, "String", { fg = "#8cbf7e" })
hl(0, "Function", { fg = "#d9c6b0", bold = true })
hl(0, "Identifier", { fg = "#a3b5a6" })
hl(0, "Type", { fg = "#74b49b" })
