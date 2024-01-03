return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			require("telescope").setup({})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("harpoon")
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
}
