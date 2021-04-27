require('plugins')
require('lspconf')
-- Local variables
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Map leader config
vim.g.mapleader=','
-- Window options
vim.wo.relativenumber=true
vim.wo.number=true
-- Global options
vim.o.hlsearch=false
vim.o.incsearch=true
vim.o.scrolloff=8
vim.o.splitright=true
-- Set colorscheme with colorbuddy
require('colorbuddy').colorscheme('gruvbuddy')
--Set Bufferline
require('bufferline').setup{}
-- Set Lualine
require('lualine').setup{options={theme='auto'}}
-- Init FTerm
require('FTerm').setup()
--Map Fterm
map('n', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<Leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
--Bufferline Keymaps
map('n', '<Leader>[', ':BufferLineCyclePrev<CR>', opts)
map('n', '<Leader>]', ':BufferLineCycleNext<CR>', opts)
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

-- Telescope
map('n', '<Leader>ff', "<CMD>lua require('telescope.builtin').find_files()<CR>", opts)
map("n", "<Leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", opts)
map("n", "<Leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", opts)
map("n", "<Leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", opts)

map("n", "<Leader>n", "<CMD>lua require('nvim-tree').toggle()<CR>", opts)
