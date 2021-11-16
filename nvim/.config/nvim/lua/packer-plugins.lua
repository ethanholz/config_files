local execute = vim.api.nvim_command
local fn = vim.fn
-- Bootstrap Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()
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
        --Movement
        use ("ggandor/lightspeed.nvim")
		-- LSP
		use("neovim/nvim-lspconfig")
		use("folke/lsp-trouble.nvim")
		use("nvim-lua/lsp-status.nvim")
		-- use("hrsh7th/cmp-buffer")
		-- use("hrsh7th/nvim-cmp")
		-- -- Snips
		-- use({ "hrsh7th/cmp-vsnip", opt = True })
		-- use({ "hrsh7th/vim-vsnip", opt = True })
		-- use({ "hrsh7th/cmp-path", opt = True })
		-- -- Other LSP tools
		-- use({ "hrsh7th/cmp-nvim-lsp" })
        use ('ms-jpq/coq_nvim', {branch= 'coq'})
        use ('ms-jpq/coq.artifacts', {branch= 'artifacts'})
        use('ms-jpq/coq.thirdparty', {branch= '3p'})
		use({ "simrat39/rust-tools.nvim" })
		use({ "onsails/lspkind-nvim" })

		use("tjdevries/nlua.nvim")
		use("nvim-lua/plenary.nvim")
		--Git
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		-- Inteface
		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use("lukas-reineke/indent-blankline.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

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
		use({ "akinsho/nvim-toggleterm.lua" })

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
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
            -- use("/home/ethanholz/Documents/presence.nvim")
		end
		use("ethanholz/nvim-lastplace")
		-- use(os.getenv("HOME") .. "/Documents/nvim-lastplace")
		use("mhartington/formatter.nvim")
		use({
			"Saecki/crates.nvim",
			event = "BufRead Cargo.toml",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		})
		use({
			"/home/ethanholz/Documents/nvim-dev/cmp-cargo",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})
	end,
})
