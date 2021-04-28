-- Map leader config
vim.g.mapleader=','

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
--Map Fterm
map('n', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<Leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
--Bufferline Keymaps
map('n', '<Leader>[', ':BufferLineCyclePrev<CR>', opts)
map('n', '<Leader>]', ':BufferLineCycleNext<CR>', opts)
-- Codi state fix
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
