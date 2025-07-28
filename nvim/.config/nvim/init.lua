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
		"bash",
		"c",
		"dockerfile",
		"gitcommit",
		"go",
		"gomod",
		"lua",
		"python",
		"query",
		"rust",
		"toml",
		"yaml",
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
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	modules = {},
})
vim.filetype.add({ extension = { mdx = "mdx", service = "systemd" } })
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("html", "superhtml")

require("treesitter-context").setup()

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

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = { current_line = true },
})
