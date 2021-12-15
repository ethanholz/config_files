vim.o.completeopt = "menuone,noinsert,noselect"
-- local cmp = require("cmp")
local lspkind = require("lspkind")
-- require("cmp-cargo").setup({})
-- cmp.setup({
-- 	formatting = {
-- 		format = lspkind.cmp_format({
-- 			with_text = true,
-- 			maxwidth = 50,
-- 			menu = {
-- 				buffer = "[Buffer]",
-- 				nvim_lsp = "[LSP]",
-- 				path = "[Path]",
-- 				crates = "[Crates]",
-- 			},
-- 		}),
-- 	},
-- 	snippet = {
-- 		expand = function(args)
-- 			-- For `vsnip` user.
-- 			vim.fn["vsnip#anonymous"](args.body)
--
-- 			-- For `luasnip` user.
-- 			-- require('luasnip').lsp_expand(args.body)
--
-- 			-- For `ultisnips` user.
-- 			-- vim.fn["UltiSnips#Anon"](args.body)
-- 		end,
-- 	},
-- 	mapping = {
-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 		["<C-e>"] = cmp.mapping.close(),
-- 		["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "path" },
-- 		-- For vsnip user.
-- 		{ name = "vsnip" },
-- 		{ name = "cmp-cargo", keyword_length = 3 },
-- 		{ name = "crates" },
-- 		-- For luasnip user.
-- 		-- { name = 'luasnip' },
-- 		{ name = "buffer" },
-- 	},
-- })
local nvim_lsp = require("lspconfig")
vim.g.coq_settings = { auto_start = "shut-up" }
local coq = require("coq")
local capabilities = coq.lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "pyright", "vimls", "ansiblels", "bashls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
local rust_opts = {
	server = {
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
	},
}
require("rust-tools").setup(rust_opts)
require("trouble").setup({})
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics

require("null-ls").setup({
	sources = {
		formatting.stylua,
		formatting.black,
		formatting.rustfmt,
		formatting.shfmt,
		formatting.trim_newlines,
		diagnostics.pylint,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
