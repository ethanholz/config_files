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
		version = "^4",
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
		config = true,
	},
	"ziglang/zig.vim",

	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"nvim-lua/plenary.nvim",
		},
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-textobjects",
	"mrjones2014/nvim-ts-rainbow",
	"nvim-treesitter/nvim-treesitter-context",
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "v2.*",
		build = "make install_jsregexp",
	},
	-- UI
	{
		"EdenEast/nightfox.nvim",
		config = function()
			-- vim.cmd.colorscheme("carbonfox")
			-- vim.cmd.colorscheme("terafox")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
			})
			vim.cmd.colorscheme("rose-pine")
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
