local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
local plugins = {
    "neovim/nvim-lspconfig",
    "folke/lsp-trouble.nvim",
    "nvim-lua/lsp-status.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "simrat39/rust-tools.nvim",
    "onsails/lspkind-nvim",
    {
        "j-hui/fidget.nvim",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    -- Debugging
    "mfussenegger/nvim-dap",
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
    },
    -- Filetype plugins
    {
        "pearofducks/ansible-vim",
        ft = "ansible.yaml",
    },
    {
        "saltstack/salt-vim",
    },
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "p00f/nvim-ts-rainbow",
    {
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        build = ":TSInstall query",
    },
    "nvim-treesitter/nvim-treesitter-context",
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        version = "*",
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Git
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = true,
    },

    -- UI
    {
        "EdenEast/nightfox.nvim",
        config = function()
            vim.cmd.colorscheme("carbonfox")
        end,
    },
    "nvim-lualine/lualine.nvim",
    "stevearc/dressing.nvim",

    -- Code help
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("harpoon")
            require("telescope").load_extension("luasnip")
        end,
        lazy = true,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
        },
        build = "make",
    },
    {
        "benfowler/telescope-luasnip.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
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
    {
        "andythigpen/nvim-coverage",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },
}

require("lazy").setup(plugins)
