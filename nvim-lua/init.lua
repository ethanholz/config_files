require('plugins')
require('lspconf')
require('mappings')

-- Window options
vim.wo.relativenumber=true
vim.wo.number=true
-- Global options
vim.o.hlsearch=false
vim.o.incsearch=true
vim.o.scrolloff=8
vim.o.splitright=true

vim.g.material_style="darker"
vim.g.material_contrast = true
require('material').set()
--Set Bufferline
require('bufferline').setup{}
-- Set Lualine
require('lualine').setup{options={theme='material-nvim'}}
-- Init FTerm
require('FTerm').setup{border="double"}
-- Treesitter Consistent Syntax Highlighting and indent
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  indent = {
     enable = true,
  },
  rainbow = {
	  enable=true,
	  extended_mode=true,
	}
}
vim.api.nvim_set_var('codi#interpreters', {python = { bin= 'python3'}})

