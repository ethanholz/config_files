return {
	{ "neovim/nvim-lspconfig" },
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({ default_mappings = true })
		end,
	},
	{
		"folke/lsp-trouble.nvim",
		config = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"jose-elias-alvarez/null-ls.nvim",
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = true,
		on = { "LspAttach" },
	},
	"simrat39/rust-tools.nvim",
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
	{
		"pest-parser/pest.vim",
		ft = "pest",
		config = true,
	},

	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"petertriho/cmp-git",
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
	{
		"nvim-treesitter/playground",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		build = ":TSInstall query",
	},
	"nvim-treesitter/nvim-treesitter-context",
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "v2.1",
		build = "make install_jsregexp",
	},
	-- UI
	{
		"EdenEast/nightfox.nvim",
		config = function()
			-- vim.cmd.colorscheme("carbonfox")
			vim.cmd.colorscheme("terafox")
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"jackMort/ChatGPT.nvim",
		-- event = "VeryLazy",
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatpGPTRun" },
		opts = {
			api_key_cmd = "op read op://personal-api-auth/ChatGPT/credential --no-newline",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	"mfussenegger/nvim-lint",
	{
		"mrjones2014/op.nvim",
		build = "make install",
		config = true,
	},
}
