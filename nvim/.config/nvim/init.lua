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
-- vim.g.nightfox_style = "palefox"
require("nightfox").set()

require("lualine").setup({ options = { theme = "nightfox" } })
-- require('lualine').setup {options = {theme = 'material-nvim'}}
-- Set Bufferline
require("bufferline").setup()
require("toggleterm").setup()
require("gitsigns").setup()

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			["foo.bar"] = "Identifier",
		},
	},
	rainbow = { enable = true, extended_mode = true },
})
vim.api.nvim_set_var("codi#interpreters", { python = { bin = "python3" } })
-- Neoformat config
-- vim.g.neoformat_enabled_python = {'black'}
-- formatter.nvim config
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePost * :silent FormatWrite
augroup END
]])
