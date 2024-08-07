vim.o.completeopt = "menuone,noinsert,noselect"
local lspkind = require("lspkind")
local nvim_lsp = require("lspconfig")
local configs = require("lspconfig.configs")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()
if not configs.superhtml then
	configs.superhtml = {
		default_config = {
			name = "superhtml",
			cmd = { "superhtml", "lsp" },
			filetypes = { "html", "superhtml", "htm", "shtml" },
			root_dir = require("lspconfig.util").root_pattern(".git"),
		},
	}
end
cmp.setup({
	sorting = {
		priority_weight = 2,
		comparators = {
			require("copilot_cmp.comparators").prioritize,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			symbol_map = { Copilot = "" },
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
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
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end),
		["<S-TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end),
	},
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "nvim_lsp_signature_help", group_index = 2 },
		{ name = "nvim_lsp_lua", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "crates", group_index = 2 },
		{ name = "buffer", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "git", group_index = 2 },
	}),
	experimental = {
		ghost_text = true,
	},
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
		{ name = "buffer" },
	}),
})
require("cmp_git").setup()
-- A table of servers used for setting up LSP
local servers = {
	"ccls",
	"ocamllsp",
	"bashls",
	"gleam",
	"marksman",
	"superhtml",
	{
		"pyright",
		settings = {
			pyright = {
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					ignore = "*",
				},
			},
		},
	},
	-- "pyright",
	"solc",
	"nixd",
	"zls",
	"pylyzer",
	"ruff",
	{
		"terraformls",
		exec = "terraform-ls",
	},
	-- {
	-- 	"ruff_lsp",
	-- 	exec = "ruff-lsp",
	-- },
	{
		"grammarly",
		exec = "grammarly-languageserver",
	},
	{
		"ansiblels",
		exec = "ansible-language-server",
	},
	{
		"eslint",
		exec = "vscode-eslint-language-server",
	},
	{
		"nil_ls",
		exec = "nil",
		settings = {
			["nil"] = {
				formatting = {
					command = { "nixpkgs-fmt" },
				},
			},
		},
	},
	{
		"ltex",
		exec = "ltex-ls",
		settings = {
			enabled = { "markdown" },
		},
	},
	{
		"tsserver",
		exec = "typescript-language-server",
	},
	{
		"astro",
		exec = "astro-ls",
	},
	{
		"lua_ls",
		exec = "lua-language-server",
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global and `awesome`
					globals = { "vim", "use", "beautiful", "awful" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				hint = {
					enable = true,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	{ "vimls", exec = "vim-language-server" },
	{ "vuels", exec = "vls" },
	{ "salt_ls", exec = "salt_lsp_server" },
	{ "dockerls", exec = "docker-langserver" },
	{
		"gopls",
		settings = {
			gopls = {
				gofumpt = true,
				analyses = {
					unusedparams = true,
					shadow = true,
					structtag = false,
				},
				staticcheck = true,
				codelenses = { test = true },
				hints = {
					assignVariableTypes = true,
					composeLiteralFields = true,
					constantValues = true,
					functionTypeParameter = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
}

-- Only install servers that exist + use custom options
for _, server in ipairs(servers) do
	local exec = ""
	local lsp = ""
	local setup = { capabilities = capabilities }
	if type(server) == "table" then
		lsp = server[1]
		if server.enable ~= nil and server.continue then
			goto continue
		end
		if server.exec ~= nil then
			exec = server.exec
		else
			exec = lsp
		end
		if server.settings ~= nil then
			setup["settings"] = server.settings
		end
		if server.init_options ~= nil then
			setup["init_options"] = server.init_options
		end
	else
		lsp = server
		exec = server
	end

	local command = [[echo executable("]] .. exec .. [[")]]
	local out = vim.api.nvim_exec2(command, { output = true })
	local result = tonumber(out.output)
	if result ~= 0 then
		nvim_lsp[lsp].setup(setup)
	end
	::continue::
end

vim.g.rustaceanvim = {
	server = {
		capabilities = capabilities,
		["rust-analyzer"] = {
			-- procMacro = {
			-- 	enable = true,
			-- },
			diagnostics = {
				enable = true,
				enable_experimental = true,
			},
		},
	},
}

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		-- if not (args.data and args.data.client_id) then
		-- 	return
		-- end
		--
		-- local bufnr = args.buf
		-- local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- local palette = require("nightfox.palette").load("carbonfox")
		-- local bg = palette.bg1
		-- vim.cmd([[hi LSPInlayHint guibg=]] .. bg .. [[gui=bold]])
		-- require("lsp-inlayhints").on_attach(client, bufnr)
		vim.lsp.inlay_hint.enable(true)
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttach_Python", {}),
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})

-- require("rust-tools").setup(rust_opts)
require("trouble").setup({})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	-- you can reuse a shared lspconfig on_attach callback here
	debug = true,
	sources = {
		formatting.stylua,
		-- diagnostics.actionlint,
		-- diagnostics.mypy,
	},
})
