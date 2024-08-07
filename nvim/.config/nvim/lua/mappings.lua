-- Map leader config
vim.cmd.timeoutlen = 0
local wk = require("which-key")

-- Register LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		wk.add({
			{ "<leader>c", group = "LSP Code Changes" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>R", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>f", group = "LSP Find" },
			{ "<leader>fl", require("telescope.builtin").lsp_document_symbols, desc = "LSP Document Symbols" },
			{ "g", group = "LSP Goto" },
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{ "gr", require("telescope.builtin").lsp_references, desc = "References" },
			{ "gi", require("telescope.builtin").lsp_implementations, desc = "Implementations" },
			{ "K", vim.lsp.buf.hover, desc = "Hover (LSP)" },
		})
	end,
})

-- Register Go mappings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	group = vim.api.nvim_create_augroup("UserGoConfig", {}),
	callback = function()
		wk.add({
			{ "<leader>gt", group = "Go Tags" },
			{ "<leader>gta", group = "Add Tags" },
			{ "<leader>gtaj", "<cmd>GoTagAdd json<cr>", desc = "Add JSON tags" },
			{ "<leader>gtay", "<cmd>GoTagAdd yaml<cr>", desc = "Add YAML tags" },
			{ "<leader>gtr", group = "Remove Tags" },
			{ "<leader>gtrj", "<cmd>GoTagRm json<cr>", desc = "Remove JSON tags" },
			{ "<leader>gtry", "<cmd>GoTagRm yaml<cr>", desc = "Remove YAML tags" },
		})
	end,
})

wk.add({
	{ "<leader>f", group = "Telescope" },
	{ "<leader>ff", require("telescope.builtin").find_files, desc = "Find File" },
	{ "<leader>fg", require("telescope.builtin").live_grep, desc = "Live Grep" },
	{ "<leader>fb", require("telescope.builtin").buffers, desc = "Buffer List" },
	{ "<leader>fh", require("telescope.builtin").help_tags, desc = "Help Tags" },
	{ "<leader>fc", require("telescope.builtin").colorscheme, desc = "Colorschme" },
	{ "<leader>fq", require("telescope").extensions.harpoon.marks, desc = "Harpoon Marks" },
	{ "<leader>fs", require("telescope.builtin").grep_string, desc = "Grep String" },
	{ "<leader>g", group = "Git" },
	{ "<leader>gg", vim.cmd.Git, desc = "Open vim-fugitive" },
	{ "<leader>gs", group = "Git Stage" },
	{ "<leader>gsh", require("gitsigns").stage_hunk, desc = "Stage Hunk" },
	{ "<leader>gsb", require("gitsigns").stage_buffer, desc = "Stage Buffer" },
	{ "<leader>gb", require("gitsigns").blame_line, desc = "Blame Line" },
	{ "<leader>p", '"+p', desc = "Paste from clipboard" },
	{ "<leader>q", require("harpoon.ui").toggle_quick_menu, desc = "Harpoon Quick Menu" },
	{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTreeToggle" },
	{ "<leader>s", require("telescope.builtin").spell_suggest, desc = "Spell suggest" },
	{ "gk", vim.diagnostic.goto_prev, desc = "Go to Prev Diagnostic" },
	{ "gj", vim.diagnostic.goto_next, desc = "Go to Next Diagnostic" },
	{ "<space>c", vim.cmd.cclose, desc = "Close qf list" },
	{ "<Esc>", "<C-\\><C-n>", desc = "Exit terminal" },
	{ "<leader>y", '"+y', desc = "Yank to clipboard" },
	{ "<leader>g", group = "Git" },
	{ "<leader>gs", group = "Git Stage" },
	{
		mode = { "v", "n" },
		{
			"<leader>gsh",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Stage Hunk",
		},
		{
			"<leader>gsr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Reset Hunk",
		},
		{ "<leader>z", ":Freeze<cr>", desc = "Freeze" },
		{ "<S-j>", ":m '>+<CR>gv=gv", desc = "Move down selection" },
		{ "<S-k>", ":m '<-2<CR>gv=gv", desc = "Move up selection" },
	},
	{
		mode = { "t" },
		{ "<ESC>", "<C-\\><C-n>", desc = "Exit terminal" },
	},
	{
		"<leader>1",
		function()
			require("harpoon.ui").nav_file(1)
		end,
		desc = "Harpoon 1",
	},
	{
		"<leader>2",
		function()
			require("harpoon.ui").nav_file(2)
		end,
		desc = "Harpoon 2",
	},
	{
		"<leader>3",
		function()
			require("harpoon.ui").nav_file(3)
		end,
		desc = "Harpoon 3",
	},
	{
		"<leader>4",
		function()
			require("harpoon.ui").nav_file(4)
		end,
		desc = "Harpoon 4",
	},
	{
		"<leader>5",
		function()
			require("harpoon.ui").nav_file(5)
		end,
		desc = "Harpoon 5",
	},
})
