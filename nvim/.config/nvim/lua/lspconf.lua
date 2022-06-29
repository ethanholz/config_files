vim.o.completeopt = "menuone,noinsert,noselect"
local lspkind = require("lspkind")
local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format(),
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	ghost_text = true,
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "pyright", "vimls", "ansiblels", "dockerls", "bashls", "solc", "eslint", "gopls", "marksman" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
	})
end
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "use" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
})
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
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
