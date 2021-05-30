local execute = vim.api.nvim_command
local fn = vim.fn
-- Bootstrap Packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local is_wsl = (function()
    local output = vim.fn.systemlist "uname -r"
    return not not string.find(output[1] or "", "WSL")
end)()
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute 'packadd packer.nvim'
end
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Manage itself
    use 'wbthomason/packer.nvim'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'folke/lsp-trouble.nvim'

    -- Inteface
    -- use {'kyazdani42/nvim-web-devicons', opt = true}
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'shaunsingh/nord.nvim'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'p00f/nvim-ts-rainbow'

    -- Code help
    use 'metakirby5/codi.vim'
    use 'b3nj5m1n/kommentary'
    use {"akinsho/nvim-toggleterm.lua"}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    if not is_wsl then use 'andweeb/presence.nvim' end
    use 'ethanholz/nvim-lastplace'
    -- use '~/Documents/nvim-lastplace/'
end)
