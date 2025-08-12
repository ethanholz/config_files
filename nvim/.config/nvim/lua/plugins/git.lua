return {
    -- Git
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<leader>gg", vim.cmd.Git, desc = "Open vim-fugitive" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "BufReadPre",
        opts = {
            on_attach = function(bufnr)
                local signs = require("gitsigns")
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    if type(mode) == "table" then
                        for _, m in ipairs(mode) do
                            vim.keymap.set(m, l, r, opts)
                        end
                    else
                        vim.keymap.set(mode, l, r, opts)
                    end
                end
                map({ "v", "n" }, "<leader>gsh", function()
                    signs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Stage hunk" })
                map("n", "<leader>gsb", signs.stage_buffer, { desc = "Stage buffer" })
                map({ "v", "n" }, "<leader>gsr", function()
                    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Reset hunk" })
                map("n", "<leader>gb", signs.blame_line, { desc = "Blame Line" })
            end,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = "250",
            },
        },
    },
}
