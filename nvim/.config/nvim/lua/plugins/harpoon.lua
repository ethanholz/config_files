return {
	{
		"ThePrimeagen/harpoon",
		opts = {
			tabline = true,
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		keys = {
			{
				"<leader>m",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon Mark",
			},
		},
	},
}
