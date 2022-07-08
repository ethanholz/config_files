-- Map leader config
vim.g.mapleader = ","
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Map Terminal
map("n", "<Leader>t", "<CMD>ToggleTerm<CR>", opts)
map("t", "<Leader>t", "<C-\\><C-n><CMD>ToggleTerm<CR>", opts)
map("t", "<A-h>", " <C-\\><C-N><C-w>h", opts)
map("t", "<A-j>", " <C-\\><C-N><C-w>j", opts)
map("t", "<A-k>", " <C-\\><C-N><C-w>k", opts)
map("t", "<A-l>", " <C-\\><C-N><C-w>l", opts)
-- BarBar Keymaps
map("n", "<Leader>[", ":BufferPrevious<CR>", opts)
map("n", "<Leader>]", ":BufferNext<CR>", opts)

-- Telescope
map("n", "<Leader>ff", require("telescope.builtin").find_files, opts)
map("n", "<Leader>fg", require("telescope.builtin").live_grep, opts)
map("n", "<Leader>fb", require("telescope.builtin").buffers, opts)
map("n", "<leader>fh", require("telescope.builtin").help_tags, opts)
map("n", "<leader>fc", require("telescope.builtin").colorscheme, opts)
map("n", "<leader>fl", require("telescope.builtin").lsp_document_symbols, opts)

--Custom bootstrap
map("n", "<Leader>bs", ":Bootstrap<CR>", opts)
-- LSP
map("n", "<Leader>i", ":TroubleToggle<CR>", opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<Leader>n", vim.diagnostic.goto_next, opts)
map("n", "<Leader>N", vim.diagnostic.goto_prev, opts)

-- Clipboard
map("v", "<Leader>y", '"+y', opts)
map("n", "<Leader>p", '"+p', opts)

-- Git
map("n", "<Leader>g", require("neogit").open, opts)

-- Harpoon
map("n", "<Leader>m", require("harpoon.mark").add_file, opts)
map("n", "<Leader>q", require("harpoon.ui").toggle_quick_menu, opts)
map("n", "1", function()
	require("harpoon.ui").nav_file(1)
end, opts)
map("n", "2", function()
	require("harpoon.ui").nav_file(2)
end, opts)
map("n", "3", function()
	require("harpoon.ui").nav_file(3)
end, opts)
map("n", "4", function()
	require("harpoon.ui").nav_file(4)
end, opts)
