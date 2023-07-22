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
	"nvim-lua/lsp-status.nvim",
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
		build = function()
			if not require("nvim-treesitter.parsers").has_parser("go") then
				vim.cmd("TSInstall go")
			end
		end,
		config = true,
	},
	"onsails/lspkind-nvim",
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
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"petertriho/cmp-git",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = true,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = true,
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
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = true,
	-- },
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
			require("telescope").setup({
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("luasnip")
			require("telescope").load_extension("file_browser")
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
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		lazy = true,
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
		dir = "/home/ethan/Documents/github/nvim-lastplace",
	},
	{
		"farmergreg/vim-lastplace",
		lazy = false,
		enabled = false,
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
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = "nvim-tree/nvim-web-devicons",
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
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "op read op://personal-api-auth/ChatGPT/credential --no-newline",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
}

require("lazy").setup(plugins)
