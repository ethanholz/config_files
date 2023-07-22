-- Map leader config
vim.g.mapleader = ","
vim.cmd.timeoutlen = 0
-- local opts = { noremap = true, silent = true }
-- local map = vim.keymap.set
local wk = require("which-key")
local v = { mode = "v", noremap = "true" }
local t = { mode = "t", noremap = "true" }

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new({
	cmd = "gitui",
	hidden = true,
	direction = "float",
	on_open = function()
		vim.cmd("startinsert!")
	end,
})
local function gitui_toggle()
	gitui:toggle()
end

local function toggle_jq()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_line, start_col, end_line, end_col = unpack(vim.fn.getpos("'<"))
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
	-- io.popen("jq --argjson in '" .. selection .. "'", "w"):close()
end

local function gitlinker_callback()
	require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
end

wk.register({
	["<leader>"] = {
		c = {
			name = "LSP Code Changes",
			a = { vim.lsp.buf.code_action, "Code Action" },
			R = { vim.lsp.buf.rename, "Rename" },
		},
		f = {
			name = "Telescope",
			f = { require("telescope.builtin").find_files, "Find File" },
			g = { require("telescope.builtin").live_grep, "Live Grep" },
			b = { require("telescope.builtin").buffers, "Buffer List" },
			h = { require("telescope.builtin").help_tags, "Help Tags" },
			c = { require("telescope.builtin").colorscheme, "Colorschme" },
			l = { require("telescope.builtin").lsp_document_symbols, "LSP Document Symbols" },
			q = { require("telescope").extensions.harpoon.marks, "Harpoon Marks" },
			s = { require("telescope.builtin").grep_string, "Grep String" },
		},
		g = {
			name = "Git",
			g = { vim.cmd.Git, "Open vim-fugitive" },
			s = {
				name = "Stage",
				h = { require("gitsigns").stage_hunk, "Stage Hunk" },
				b = { require("gitsigns").stage_buffer, "Stage Buffer" },
			},
			b = { require("gitsigns").blame_line, "Blame Line" },
			u = { gitui_toggle, "gitui toggle" },
			o = { gitlinker_callback, "gitinker" },
		},
		j = { toggle_jq, "jq" },
		m = { require("harpoon.mark").add_file, "Harpoon Mark" },
		p = { '"+p', "Paste from clipboard" },
		q = { require("harpoon.ui").toggle_quick_menu, "Harpoon Quick Menu" },
		u = { "<cmd>UndotreeToggle<cr>", "UndoTreeToggle" },
		i = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
		s = { require("telescope.builtin").spell_suggest, "Spell suggest" },
		t = { "<cmd>ToggleTerm direction=horizontal<cr>", "New Terminal" },
	},
	["<leader>1"] = {
		function()
			require("harpoon.ui").nav_file(1)
		end,
		"Harpoon 1",
	},
	["<leader>2"] = {
		function()
			require("harpoon.ui").nav_file(2)
		end,
		"Harpoon 2",
	},
	["<leader>3"] = {
		function()
			require("harpoon.ui").nav_file(3)
		end,
		"Harpoon 3",
	},
	["<leader>4"] = {
		function()
			require("harpoon.ui").nav_file(4)
		end,
		"Harpoon 4",
	},
	["g"] = {
		d = { vim.lsp.buf.definition, "Goto Definition" },
		j = { vim.diagnostic.goto_next, "Go to Next Diagnostic" },
		k = { vim.diagnostic.goto_prev, "Go to Prev Diagnostic" },
		r = { require("telescope.builtin").lsp_references, "References" },
		i = { require("telescope.builtin").lsp_implementations, "Implementations" },
		t = {
			name = "Go Tags",
			a = {
				name = "Add Tags",
				j = { ":GoTagAdd json <cr>", "JSON" },
				y = { ":GoTagAdd yaml <cr>", "YAML" },
			},
			r = {
				name = "Remove Tags",
				j = { ":GoTagRm json <cr>", "JSON" },
				y = { ":GoTagRm yaml <cr>", "YAML" },
			},
			f = { ":GoIfErr<cr>", "iferr" },
		},
	},
	["space"] = {
		c = { vim.cmd.cclose, "Close qf list" },
	},
	["K"] = { vim.lsp.buf.hover, "Hover (LSP)" },
	["<S-f>"] = { require("telescope").extensions.file_browser.file_browser, "Open file picker" },
})
wk.register({
	["<leader>"] = {
		y = { '"+y', "Yank to clipboard" },
		f = {
			name = "Telescope",
			s = { require("telescope.builtin").grep_string, "Grep String" },
		},
	},
}, v)
wk.register({
	["<Esc>"] = { "<C-\\><C-n>", "Exit terminal" },
}, t)
-- -- Debugs
-- map("n", "<Leader>dt", require("dapui").toggle, opts)
-- map("n", "<Leader>tt", require("dap").toggle_breakpoint, opts)
-- map("n", "<F5>", require("dap").continue, opts)
-- map("n", "<F2>", require("dap").step_into, opts)
-- map("n", "<F12>", require("dap").step_over, opts)
