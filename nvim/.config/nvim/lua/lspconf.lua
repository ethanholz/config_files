vim.o.completeopt = "menuone,noinsert,noselect"
local lspkind = require("lspkind")
local nvim_lsp = require("lspconfig")
-- vim.g.coq_settings = { auto_start = "shut-up" }
-- local coq = require("coq")
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<TAB>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	}),
	ghost_text = true,
})
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "pyright", "vimls", "ansiblels", "dockerls", "bashls", "solc", "eslint", "gopls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
local rust_opts = {
	server = {
		on_attach = function(client)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
	},
}
require("rust-tools").setup(rust_opts)
require("trouble").setup({})
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
local code_actions = require("null-ls").builtins.code_actions
require("null-ls").setup({
	sources = {
		formatting.stylua,
		formatting.black,
		-- formatting.rustfmt,
		formatting.isort,
		diagnostics.pylama,
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			buf_func = vim.lsp.buf.formatting_sync
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
