require('plugins')
require('lspconf')

-- Map leader config
vim.g.mapleader=','
vim.wo.relativenumber=true
-- Set colorscheme with colorbuddy
require('colorbuddy').colorscheme('gruvbuddy')
--Set Bufferline
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
--Bufferline Keymaps
map('n', '<Leader>[', ':BufferLineCyclePrev<CR>', {noremap=true, silent=true})
map('n', '<Leader>]', ':BufferLineCycleNext<CR>', {noremap=true, silent=true})
-- Treesitter Consistent Syntax Highlighting and indent
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    indent = {
	    enable = true,
    },
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
vim.api.nvim_set_var('codi#interpreters', {python = { bin= 'python3'}})
local codi_state = false
toggle_codi = function()
	if codi_state == false then
		codi_state=true
		vim.cmd([[Codi]])
	else
		codi_state=false
		vim.cmd([[Codi!]])
	end
end
map('n', '<Leader>c', '<CMD>lua toggle_codi()<CR>', opts)
