--------------------------------------------------
-- Options
--------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect", "popup" }

--------------------------------------------------
-- Leader
--------------------------------------------------
vim.g.mapleader = " "

--------------------------------------------------
-- Keybindings
--------------------------------------------------
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>")
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<leader>so", function()
    vim.cmd("update")
    vim.cmd("source %")
end, { desc = "Save and source file" })

--------------------------------------------------
-- Diagnostics
--------------------------------------------------
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = "rounded" },
    update_in_insert = false,
    severity_sort = true,
})

vim.keymap.set("n", "gn", function()
    vim.diagnostic.jump({ count = 1 })
end)

vim.keymap.set("n", "gh", function()
    vim.diagnostic.jump({ count = -1 })
end)

vim.keymap.set("n", "gf", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>gl", vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>dt", function()
    local cfg = vim.diagnostic.config()
    vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
end)

--------------------------------------------------
-- Format
--------------------------------------------------
vim.keymap.set("n", "f", function()
    vim.lsp.buf.format({ async = true })
end)

--------------------------------------------------
-- Plugins (vim.pack)
--------------------------------------------------
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },

    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },

    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/xiyaowong/transparent.nvim" },

    { src = "https://github.com/m4xshen/autoclose.nvim" },
    { src = "https://github.com/otavioschwanck/arrow.nvim" },
    { src = "https://github.com/junegunn/fzf.vim" },

})

--------------------------------------------------
-- Colorscheme / Transparency
--------------------------------------------------
vim.cmd.colorscheme("catppuccin")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
vim.cmd("hi StatusLine guibg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none" })

--------------------------------------------------
-- Mason + LSP
--------------------------------------------------
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "bashls",
        "gopls",
        "rust_analyzer",
        "ts_ls",
    },
    automatic_installation = true,
})

--------------------------------------------------
-- LSP capabilities (IMPORTANT for snippets)
--------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "lua_ls",
    "pyright",
    "bashls",
    "gopls",
    "rust_analyzer",
    "ts_ls",
    "html-lsp",
    "css-lsp",
})

--------------------------------------------------
-- nvim-cmp + LuaSnip (THIS restores snippets)
--------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})

--------------------------------------------------
-- Auto close
--------------------------------------------------
require("autoclose").setup()



--------------------------------------------------
-- Arrow.nvim
--------------------------------------------------
require("arrow").setup({
    show_icons = false,

    mappings = {
        toggle = "m",
        open_vertical = "v",
        open_horizontal = "-",
        quit = "q",
        delete_mode = "d",
    },

    leader_key = ";",
    save_key = "cwd",
})

vim.keymap.set("n", "H", require("arrow.persist").previous)
vim.keymap.set("n", "L", require("arrow.persist").next)
vim.keymap.set("n", "<C-s>", require("arrow.persist").toggle)

--------------------------------------------------
-- FZF (fzf.vim)
--------------------------------------------------

-- Files
vim.keymap.set("n", "<leader>ff", "<cmd>Files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>GFiles<CR>", { desc = "Git files" })
vim.keymap.set("n", "<leader>fG", "<cmd>GFiles?<CR>", { desc = "Git changed files" })

-- Search (ripgrep / ag)
vim.keymap.set("n", "<leader>rg", "<cmd>Rg<CR>", { desc = "Ripgrep search" })
vim.keymap.set("n", "<leader>rG", "<cmd>RG<CR>", { desc = "Live ripgrep" })
vim.keymap.set("n", "<leader>ag", "<cmd>Ag<CR>", { desc = "Silver searcher" })

-- Buffers
vim.keymap.set("n", "<leader>bb", "<cmd>Buffers<CR>", { desc = "Open buffers" })
vim.keymap.set("n", "<leader>bl", "<cmd>Lines<CR>", { desc = "Search lines (all buffers)" })
vim.keymap.set("n", "<leader>bc", "<cmd>BLines<CR>", { desc = "Search lines (current buffer)" })

-- Tags
vim.keymap.set("n", "<leader>tt", "<cmd>Tags<CR>", { desc = "Project tags" })
vim.keymap.set("n", "<leader>tb", "<cmd>BTags<CR>", { desc = "Buffer tags" })

-- Git commits (requires fugitive)
vim.keymap.set("n", "<leader>gc", "<cmd>Commits<CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>gC", "<cmd>BCommits<CR>", { desc = "Buffer commits" })

-- History
vim.keymap.set("n", "<leader>fh", "<cmd>History<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>ch", "<cmd>History:<CR>", { desc = "Command history" })
vim.keymap.set("n", "<leader>sh", "<cmd>History/<CR>", { desc = "Search history" })

-- Marks / Jumps
vim.keymap.set("n", "<leader>mk", "<cmd>Marks<CR>", { desc = "Marks" })
vim.keymap.set("n", "<leader>jm", "<cmd>Jumps<CR>", { desc = "Jumps" })

-- Misc
vim.keymap.set("n", "<leader>cs", "<cmd>Colors<CR>", { desc = "Color schemes" })
vim.keymap.set("n", "<leader>cm", "<cmd>Commands<CR>", { desc = "Commands list" })
vim.keymap.set("n", "<leader>mp", "<cmd>Maps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>ht", "<cmd>Helptags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>ft", "<cmd>Filetypes<CR>", { desc = "Filetypes" })
