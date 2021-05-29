require('packer-plugins')
require('lspconf')
require('mappings')

tab_value = 4
-- Window options
vim.wo.relativenumber=true
vim.wo.number=true
-- Global options
vim.o.hlsearch=false
vim.o.incsearch=true
vim.o.scrolloff=8
vim.o.splitright=true
vim.bo.expandtab=true
vim.bo.tabstop=tab_value
vim.bo.softtabstop=tab_value
vim.bo.shiftwidth=tab_value
    
require'nvim-lastplace'.setup{}
--[[ vim.g.nb_style = "midnight"
require('colorbuddy').colorscheme('nightbuddy') ]]
require('nord').set()

--Set Bufferline
require('bufferline').setup{}
-- Set Lualine
require('lualine').setup{options={theme='nord'}}
-- Init FTerm
-- require('FTerm').setup{border="double"}
-- Treesitter Consistent Syntax Highlighting and indent
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  rainbow = {
          enable=true,
          extended_mode=true,
        }
}
vim.api.nvim_set_var('codi#interpreters', {python = { bin= 'python3'}})
vim.cmd [[autocmd BufWritePre *.py execute ':Black']]
