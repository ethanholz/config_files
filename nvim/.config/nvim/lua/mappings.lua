-- Map leader config
vim.cmd.timeoutlen = 0
local wk = require("which-key")
local v = { mode = "v", noremap = "true" }
local t = { mode = "t", noremap = "true" }

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
			-- ["K"] = { vim.lsp.buf.hover, "Hover (LSP)" },
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

-- local home_row = { "a", "s", "d", "f", "g", "h", "j", "k", "l" }
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
			p = { require("custom.telescope-project").project_files, "Find Project File" },
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
		},
		p = { '"+p', "Paste from clipboard" },
		q = { require("harpoon.ui").toggle_quick_menu, "Harpoon Quick Menu" },
		u = { "<cmd>UndotreeToggle<cr>", "UndoTreeToggle" },
		s = { require("telescope.builtin").spell_suggest, "Spell suggest" },
		z = { ":Freeze<cr>", "Freeze" },
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
		g = {
			name = "Git",
			s = {
				name = "Stage",
				h = {
					function()
						require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					"Stage Hunk",
				},
				r = {
					function()
						require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					"Reset Hunk",
				},
			},
		},
		z = { ":Freeze<cr>", "Freeze" },
	},
	["<S-j>"] = { ":m '>+<CR>gv=gv", "Move down selection" },
	["<S-k>"] = { ":m '<-2<CR>gv=gv", "Move up selection" },
}, v)
wk.register({
	["<Esc>"] = { "<C-\\><C-n>", "Exit terminal" },
}, t)
