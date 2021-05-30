require('packer-plugins')
require('lspconf')
require('mappings')

tab_value = 4
-- Window options
vim.opt.relativenumber=true
vim.opt.number=true
-- Global options
vim.opt.hlsearch=false
vim.opt.incsearch=true
vim.opt.scrolloff=8
vim.opt.splitright=true
vim.opt.expandtab=true
vim.opt.tabstop=tab_value
vim.opt.softtabstop=tab_value
vim.opt.shiftwidth=tab_value
vim.opt.shell='zsh'
    
require'nvim-lastplace'.setup{}
--[[ vim.g.nb_style = "midnight"
require('colorbuddy').colorscheme('nightbuddy') ]]
require('nord').set{}
require('lualine').setup{options={theme='nord'}}
--Set Bufferline
require('bufferline').setup{}

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
