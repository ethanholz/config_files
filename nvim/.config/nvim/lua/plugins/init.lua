return {
	{ "neovim/nvim-lspconfig" },
	"jose-elias-alvarez/null-ls.nvim",
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = true,
		on = { "LspAttach" },
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
	},
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = "go",
		build = function()
			if not require("nvim-treesitter.parsers").has_parser("go") then
				vim.cmd("TSInstall go")
			end
		end,
		config = true,
	},
	"onsails/lspkind-nvim",
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
		"EdenEast/nightfox.nvim",
		config = function()
			-- vim.cmd.colorscheme("carbonfox")
			-- vim.cmd.colorscheme("terafox")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	"stevearc/dressing.nvim",
	-- Code help
	{
		"numToStr/Comment.nvim",
		config = true,
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
		"IndianBoy42/tree-sitter-just",
		config = true,
	},
	"NoahTheDuke/vim-just",
	"gleam-lang/gleam.vim",
}
