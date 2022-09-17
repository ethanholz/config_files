require("packer-plugins")
require("lspconf")
require("snips")
require("mappings")
require("ui")
-- local colors = require("nightfox.colors").load()
require("debug")

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
local tab_value = 4
vim.opt.tabstop = tab_value
vim.opt.softtabstop = tab_value
vim.opt.shiftwidth = tab_value
vim.opt.shell = "zsh"
vim.opt.bg = "dark"
-- vim.cmd([[command! Bootstrap lua require('format-config').bootstrap()]])

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
	playground = {
		enable = true,
	},
})
require("treesitter-context").setup()
