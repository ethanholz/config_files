local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

require('packer').startup(function(use)
	use "wbthomason/packer.nvim"
	use {"neovim/nvim-lspconfig", opt=true}
	use {'nvim-lua/completion-nvim', opt=true}
	use {
	  'hoob3rt/lualine.nvim',
	  requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}	
	use {
	    "numtostr/FTerm.nvim",
	    config = function()
		require("FTerm").setup()
	    end
	}
	use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
	use {'tjdevries/gruvbuddy.nvim', requires={'tjdevries/colorbuddy.vim', opt=true}}
	-- Treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	require_plugin("nvim-treesitter")
	require_plugin("completion-nvim")
	require_plugin("nvim-lspconfig")
end)

