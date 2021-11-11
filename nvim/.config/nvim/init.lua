require("packer-plugins")
require("lspconf")
require("format-config").setup()
require("mappings")

tab_value = 4
-- Window options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spelllang = "en"
-- Global options
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.tabstop = tab_value
vim.opt.softtabstop = tab_value
vim.opt.shiftwidth = tab_value
vim.opt.shell = "zsh"
vim.opt.bg = "dark"
vim.cmd([[command! Bootstrap lua require('format-config').bootstrap()]])
require("nvim-lastplace").setup({})
-- Load theme colors for use in UI
local colors = require("nightfox.colors").load()
require("nightfox").setup({
	terminal_colors = true,
})
require("nightfox").load()

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
		lualine_c = {},
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
-- vim.opt.list = true

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "help", "terminal" },
	filetype_exclude = { "markdown" },
})

require("toggleterm").setup()
require("gitsigns").setup()

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		colors = {
			colors.red,
			colors.yellow,
			colors.green,
			colors.blue,
			colors.cyan,
			colors.magenta,
			colors.pink,
		},
	},
})
