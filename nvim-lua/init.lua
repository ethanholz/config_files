require('plugins')
require('lspconf')

-- Map leader config
vim.g.mapleader=','
vim.wo.relativenumber=true
-- vim.o.termguicolors=true
require('bufferline').setup{}
-- Set Lualine
require('lualine').setup{options={theme='gruvbox_material'}}
-- Init FTerm
require('FTerm').setup()

--Map Fterm
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
map('n', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<Leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
map('n', '<Leader>[', ':BufferLineCyclePrev<CR>', {noremap=true, silent=true})
map('n', '<Leader>]', ':BufferLineCycleNext<CR>', {noremap=true, silent=true})
