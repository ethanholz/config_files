-- Map leader config
vim.g.mapleader = ","
vim.cmd.timeoutlen = 0
-- local opts = { noremap = true, silent = true }
-- local map = vim.keymap.set
local wk = require("which-key")
local v = { mode = "v", noremap = "true" }

wk.register({
    ["<leader>"] = {
        c = {
            name = "LSP Code Changes",
            a = { vim.lsp.buf.code_action, "Code Action" },
            R = { vim.lsp.buf.rename, "Rename" },
        },
        f = {
            name = "Telescope",
            f = { require("telescope.builtin").find_files, "Find File" },
            g = { require("telescope.builtin").live_grep, "Live Grep" },
            b = { require("telescope.builtin").buffers, "Buffer List" },
            h = { require("telescope.builtin").help_tags, "Help Tags" },
            c = { require("telescope.builtin").colorscheme, "Colorschme" },
            l = { require("telescope.builtin").lsp_document_symbols, "LSP Document Symbols" },
            q = { require("telescope").extensions.harpoon.marks, "Harpoon Marks" },
        },
        g = {
            name = "Git",
            g = { vim.cmd.Git, "Open vim-fugitive" },
            s = {
                name = "Stage",
                h = { require("gitsigns").stage_hunk, "Stage Hunk" },
                b = { require("gitsigns").stage_buffer, "Stage Buffer" },
            },
            b = { require("gitsigns").blame_line, "Blame Line" },
        },
        m = { require("harpoon.mark").add_file, "Harpoon Mark" },
        n = { require("neogen").generate, "Neogen" },
        p = { '"+p', "Paste from clipboard" },
        q = { require("harpoon.ui").toggle_quick_menu, "Harpoon Quick Menu" },
        u = { "<cmd>UndotreeToggle<cr>", "UndoTreeToggle" },
        i = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
        s = { require("telescope.builtin").spell_suggest, "Spell suggest" }
    },
    ["<leader>1"] = {
        function()
            require("harpoon.ui").nav_file(1)
        end,
        "Harpoon 1",
    },
    ["<leader>2"] = {
        function()
            require("harpoon.ui").nav_file(2)
        end,
        "Harpoon 2",
    },
    ["<leader>3"] = {
        function()
            require("harpoon.ui").nav_file(3)
        end,
        "Harpoon 3",
    },
    ["<leader>4"] = {
        function()
            require("harpoon.ui").nav_file(4)
        end,
        "Harpoon 4",
    },
    ["g"] = {
        r = { require("telescope.builtin").lsp_references, "References" },
        i = { require("telescope.builtin").lsp_implementations, "Implementations" },
        d = { vim.lsp.buf.definition, "Goto Definition" },
        j = { vim.diagnostic.goto_next, "Go to Next Diagnostic" },
        k = { vim.diagnostic.goto_prev, "Go to Prev Diagnostic" },
    },
    ["K"] = { vim.lsp.buf.hover, "Hover (LSP)" },
    ["<space>c"] = { vim.cmd.cclose, "Close qf list" },
})
wk.register({
    ["<leader>"] = {
        y = { '"+y', "Yank to clipboard" },
    },
}, v)
-- -- BarBar Keymaps
-- map("n", "<Leader>[", ":BufferPrevious<CR>", opts)
-- map("n", "<Leader>]", ":BufferNext<CR>", opts)
-- -- LSP
-- map("n", "<Leader>i", ":TroubleToggle<CR>", opts)
-- -- Debugs
-- map("n", "<Leader>dt", require("dapui").toggle, opts)
-- map("n", "<Leader>tt", require("dap").toggle_breakpoint, opts)
-- map("n", "<F5>", require("dap").continue, opts)
-- map("n", "<F2>", require("dap").step_into, opts)
-- map("n", "<F12>", require("dap").step_over, opts)
