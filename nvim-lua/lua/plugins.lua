local execute = vim.api.nvim_command
local fn = vim.fn

-- Checks if paq is installed
local paq_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paqs-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute ("!git clone https://github.com/savq/paq-nvim.git" .. install_path)
	execute "packadd paq-nvim"
end

local paq = require'paq-nvim'.paq
-- Manage itself
paq {'savq/paq-nvim', opt = true}
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
