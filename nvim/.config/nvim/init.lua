local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.g.mapleader = ","
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins")
require("custom")
require("mappings")
require("snips")

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"rust",
		"go",
		"c",
		"bash",
		"dockerfile",
		"gomod",
		"gitcommit",
		"query",
		"toml",
		"yaml",
		"hurl",
	},
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
	playground = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = { query = "@class.inner", desc = "Select inner" },
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scop" },
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["fn"] = { query = "@function.name", desc = "Select function name" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = { query = "@class.outer", desc = "Previous class" },
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			floating_preview_opts = {},
			-- peek_definition_code = {
			-- 	["<leader>df"] = "@function.outer",
			-- 	["<leader>dF"] = "@class.outer",
			-- },
		},
	},
})
vim.filetype.add({ extension = { mdx = "mdx" } })
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- local ft_parser = require("nvim-treesitter.parsers").filetype_to_parsername
---@class gotmpl
parser_config.gotmpl = {
	install_info = {
		url = "https://github.com/ngalaiko/tree-sitter-go-template",
		files = { "src/parser.c" },
	},
	filetype = "gotmpl",
	used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
}
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("html", "superhtml")

require("treesitter-context").setup()

local function LoadCoverageOnEnter()
	if vim.fn.globpath(".", "coverage.out") ~= "" then
		require("coverage").load(true)
		vim.api.nvim_create_user_command("GoCov", "!go tool cover -html coverage.out", {})
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("CoverageDisplayGroup", { clear = true }),
	pattern = { "go" },
	callback = function()
		LoadCoverageOnEnter()
	end,
})
-- Vars that hold buffer and window for testing
local buf = nil
local win = nil

local function create_output_buffer()
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	end
end

local function view_output()
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
		win = nil
	else
		if buf and vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_command("vsplit")
			win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(win, buf)
		end
	end
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("CoverageRun", { clear = true }),
	pattern = { "*_test.go" },
	callback = function()
		create_output_buffer()
		vim.api.nvim_create_user_command("ViewOutput", view_output, {})
		vim.fn.jobstart("go test -coverprofile=coverage.out", {
			stdout_buffered = true,
			on_exit = function(_, exit_code, _)
				if exit_code == 0 then
					require("coverage").load(true)
				end
			end,
			on_stdout = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
				end
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		-- vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
vim.opt.spell = false

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.service" },
	callback = function()
		vim.api.nvim_buf_set_option(0, "filetype", "systemd")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("python_options", { clear = true }),
	pattern = { "python" },
	callback = function()
		vim.opt_local.colorcolumn = "80"
	end,
})

if vim.env.ZELLIJ ~= nil then
	vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
end
vim.diagnostic.config({
	update_in_insert = false,
})
