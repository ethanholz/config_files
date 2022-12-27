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
local tab_value = 4
vim.opt.tabstop = tab_value
vim.opt.softtabstop = tab_value
vim.opt.shiftwidth = tab_value
vim.opt.expandtab = true

vim.opt.shell = "zsh"
vim.opt.bg = "dark"
vim.opt.spell = true -- Enables treesitter comment spelling
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Persistent undos
vim.opt.undofile = true
