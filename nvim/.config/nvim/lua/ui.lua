require("nightfox").setup({
	options = {
		terminal_colors = true,
	},
})
vim.cmd("colorscheme nightfox")

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "help", "terminal" },
	filetype_exclude = { "markdown" },
})

require("telescope").load_extension("fzf")
