return {
	{
		"folke/lsp-trouble.nvim",
		config = true,
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
