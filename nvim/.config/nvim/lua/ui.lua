local colors = require("nightfox.colors").load()
require("nightfox").setup({
	terminal_colors = true,
})
require("nightfox").load()
require("gitsigns").setup()

require("lualine").setup({
	options = {
		theme = "nightfox",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { "diagnostics" },
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "help", "terminal" },
	filetype_exclude = { "markdown" },
})
