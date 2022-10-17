-- Map leader config
vim.g.mapleader = ","
vim.cmd.timeoutlen = 0
-- local opts = { noremap = true, silent = true }
-- local map = vim.keymap.set
local wk = require("which-key")
local v = { mode = "v" }

wk.register({
    ["<leader>"] = {
        c = {
            name = "LSP Code Changes",
            a = { vim.lsp.buf.code_action, "Code Action" },
            R = { vim.lsp.buf.rename, "Rename" },
        },
        d = { [["d]], "Super D" },
        f = {
            name = "Telescope",
            f = { require("telescope.builtin").find_files, "Find File" },
            g = { require("telescope.builtin").live_grep, "Live Grep" },
            b = { require("telescope.builtin").buffers, "Buffer List" },
            h = { require("telescope.builtin").help_tags, "Help Tags" },
            c = { require("telescope.builtin").colorscheme, "Colorschme" },
            l = { require("telescope.builtin").lsp_document_symbols, "LSP Document Symbols" },
            m = { require("telescope").extensions.make.make, "make commands" },
            q = { require("telescope").extensions.harpoon.marks, "Harpoon Marks" },
        },
        g = {
            name = "Git",
            g = { require("neogit").open, "Open neogit" },
            s = {
                name = "Stage",
                h = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
                b = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
            },
        },
        m = { require("harpoon.mark").add_file, "Harpoon Mark" },
        p = { '"+p', "Paste from clipboard" },
        q = { require("harpoon.ui").toggle_quick_menu, "Harpoon Quick Menu" },
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
        r = { vim.lsp.buf.references, "References" },
        d = { vim.lsp.buf.definition, "Goto Definition" },
        n = { vim.diagnostic.goto_next, "Go to Next Diagnostic" },
        N = { vim.diagnostic.goto_prev, "Go to Prev Diagnostic" },
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
