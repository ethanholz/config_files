vim.cmd("colorscheme nightfox")

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "help", "terminal" },
	filetype_exclude = { "markdown" },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
