local execute = vim.api.nvim_command
local fn = vim.fn

vim.cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
-- Manage itself
paq {'savq/paq-nvim', opt=true}
-- LSP
paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'

--Inteface
paq {'kyazdani42/nvim-web-devicons', opt = true}
paq 'kyazdani42/nvim-tree.lua'
paq 'hoob3rt/lualine.nvim'	
paq 'akinsho/nvim-bufferline.lua'
paq 'marko-cerovac/material.nvim'

-- Floatterm but lua
paq 'numtostr/FTerm.nvim'

-- Treesitter
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
paq 'p00f/nvim-ts-rainbow'

-- Code help
paq 'metakirby5/codi.vim'
paq 'b3nj5m1n/kommentary'

-- Telescope
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
