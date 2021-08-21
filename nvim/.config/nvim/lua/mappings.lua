-- Map leader config
vim.g.mapleader = ","

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- Map Terminal
map("n", "<Leader>t", "<CMD>ToggleTerm<CR>", opts)
map("t", "<Leader>t", "<C-\\><C-n><CMD>ToggleTerm<CR>", opts)
map("t", "<A-h>", " <C-\\><C-N><C-w>h", opts)
map("t", "<A-j>", " <C-\\><C-N><C-w>j", opts)
map("t", "<A-k>", " <C-\\><C-N><C-w>k", opts)
map("t", "<A-l>", " <C-\\><C-N><C-w>l", opts)
-- Bufferline Keymaps
--[[ map("n", "<Leader>[", ":BufferLineCyclePrev<CR>", opts)
map("n", "<Leader>]", ":BufferLineCycleNext<CR>", opts) ]]
map("n", "<Leader>[", ":BufferPrevious<CR>", opts)
map("n", "<Leader>]", ":BufferNext<CR>", opts)
-- Codi state fix
local codi_state = false
toggle_codi = function()
	if codi_state == false then
		codi_state = true
		vim.cmd([[Codi]])
	else
		codi_state = false
		vim.cmd([[Codi!]])
	end
end

map("n", "<Leader>c", "<CMD>lua toggle_codi()<CR>", opts)
-- Telescope
map("n", "<Leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", opts)
map("n", "<Leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", opts)
map("n", "<Leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme()<cr>", opts)
map("n", "<Leader>fl", "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)

map("n", "<Leader>n", "<CMD>lua require('nvim-tree').toggle()<CR>", opts)
map("n", "<Leader>i", ":ISwap<CR>", opts)
--Custom bootstrap
map("n", "<Leader>bs", ":Bootstrap<CR>", opts)
