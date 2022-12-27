require("custom")
require("snips")
require("mappings")

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "rust", "go", "c",
        "bash", "dockerfile", "gomod",
        "gitcommit", "query", "toml", "yaml"
    },
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    playground = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})
require("treesitter-context").setup()

local function LoadCoverageOnEnter()
    if vim.fn.globpath(".", "coverage.out") ~= "" then
        require("coverage").load(true)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("CoverageDisplayGroup", { clear = true }),
    pattern = { "go" },
    callback = function()
        LoadCoverageOnEnter()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("CoverageRun", { clear = true }),
    pattern = { "*_test.go" },
    callback = function()
        io.popen("go test -coverprofile=coverage.out ./...")
        LoadCoverageOnEnter()
    end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.service" },
    callback = function()
        vim.api.nvim_buf_set_option(0, "filetype", "systemd")
    end,
})
