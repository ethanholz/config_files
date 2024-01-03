-- Map leader config
vim.cmd.timeoutlen = 0
local wk = require("which-key")
local v = { mode = "v", noremap = "true" }
local t = { mode = "t", noremap = "true" }
local t_n

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

-- Register LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		wk.register({
			["<leader>"] = {
				c = {
					name = "LSP Code Changes",
					a = { vim.lsp.buf.code_action, "Code Action" },
					R = { vim.lsp.buf.rename, "Rename" },
				},
				f = {
					l = { require("telescope.builtin").lsp_document_symbols, "LSP Document Symbols" },
				},
			},
			["g"] = {
				d = { vim.lsp.buf.definition, "Goto Definition" },
				r = { require("telescope.builtin").lsp_references, "References" },
				i = { require("telescope.builtin").lsp_implementations, "Implementations" },
			},
			["K"] = { vim.lsp.buf.hover, "Hover (LSP)" },
		})
	end,
})

-- Register Go mappings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	group = vim.api.nvim_create_augroup("UserGoConfig", {}),
	callback = function()
		wk.register({
			["g"] = {
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
		})
	end,
})

local harpoon_table = {}
for i = 1, 9 do
	harpoon_table["<leader>" .. tostring(i)] = {
		function()
			require("harpoon.ui").nav_file(i)
		end,
		"Harpoon " .. tostring(i),
	}
end

wk.register(vim.tbl_extend("force", harpoon_table, {
	["<leader>"] = {
		f = {
			name = "Telescope",
			f = { require("telescope.builtin").find_files, "Find File" },
			g = { require("telescope.builtin").live_grep, "Live Grep" },
			b = { require("telescope.builtin").buffers, "Buffer List" },
			h = { require("telescope.builtin").help_tags, "Help Tags" },
			c = { require("telescope.builtin").colorscheme, "Colorschme" },
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
		},
		p = { '"+p', "Paste from clipboard" },
		q = { require("harpoon.ui").toggle_quick_menu, "Harpoon Quick Menu" },
		u = { "<cmd>UndotreeToggle<cr>", "UndoTreeToggle" },
		i = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
		s = { require("telescope.builtin").spell_suggest, "Spell suggest" },
		t = { "<cmd>ToggleTerm direction=horizontal<cr>", "New Terminal" },
	},
	["g"] = {
		j = { vim.diagnostic.goto_next, "Go to Next Diagnostic" },
		k = { vim.diagnostic.goto_prev, "Go to Prev Diagnostic" },
	},
	["space"] = {
		c = { vim.cmd.cclose, "Close qf list" },
	},
}))
wk.register({
	["<leader>"] = {
		y = { '"+y', "Yank to clipboard" },
		f = {
			name = "Telescope",
			s = { require("telescope.builtin").grep_string, "Grep String" },
		},
	},
	["<S-j>"] = { ":m '>+<CR>gv=gv", "Move down selection" },
	["<S-k>"] = { ":m '<-2<CR>gv=gv", "Move up selection" },
}, v)
wk.register({
	["<Esc>"] = { "<C-\\><C-n>", "Exit terminal" },
}, t)
