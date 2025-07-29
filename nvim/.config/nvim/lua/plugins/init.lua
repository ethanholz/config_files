return {
    { "neovim/nvim-lspconfig" },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = { "rust" },
    },
    -- Filetype plugins
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    "ziglang/zig.vim",

    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
            },
        },
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "HiPhish/rainbow-delimiters.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    -- UI
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        "ethanholz/nvim-lastplace",
        config = true,
    },
    "mbbill/undotree",
    {
        "folke/which-key.nvim",
        config = true,
    },
}
