local is_wsl = require("helper").is_wsl()
local execute = vim.api.nvim_command
local fn = vim.fn
-- Bootstrap Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	execute("packadd packer.nvim")
end
vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
	function()
		-- Manage itself
		use({ "wbthomason/packer.nvim", opt = true })
		-- LSP
		use("neovim/nvim-lspconfig")
		use("folke/lsp-trouble.nvim")
		use("nvim-lua/lsp-status.nvim")
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use({ "simrat39/rust-tools.nvim" })
		use({ "onsails/lspkind-nvim" })
		use({ "jose-elias-alvarez/null-ls.nvim" })

		--Git
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		})
        use ({
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("neogit").setup()
            end,
        })

		-- Inteface
		use({
			"romgrk/barbar.nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
				opt = true,
			},
		})
		use("lukas-reineke/indent-blankline.nvim")
		use("EdenEast/nightfox.nvim")

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("p00f/nvim-ts-rainbow")

		-- Code help
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({
			"akinsho/nvim-toggleterm.lua",
			config = function()
				require("toggleterm").setup()
			end,
		})
		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})
		use({
			"sudormrfbin/cheatsheet.nvim",
			-- optional
			requires = {
				{ "nvim-telescope/telescope.nvim" },
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})
		if not is_wsl then
			use("andweeb/presence.nvim")
		end
		use({
			"ethanholz/nvim-lastplace",
			branch = "testing",
			config = function()
				require("nvim-lastplace").setup({})
			end,
		})
		use({
			"Saecki/crates.nvim",
			event = "BufRead Cargo.toml",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		})
	end,
})
