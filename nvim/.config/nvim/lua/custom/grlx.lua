vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("grlx", {}),
	pattern = "grlx",
	callback = function()
		vim.lsp.start({
			name = "grlx-lsp",
			cmd = { "grlx-lsp" },
			root_dir = vim.loop.cwd(),
			flags = { exit_timeout = 1000 },
		})
	end,
})
