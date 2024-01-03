return {
	-- Git
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = true,
	},
}
