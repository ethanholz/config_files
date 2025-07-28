vim.o.completeopt = "menuone,noinsert,noselect"
-- local lspkind = require("lspkind")
-- A table of servers used for setting up LSP
local servers = {
	-- "bashls",
	"superhtml",
	"pyright",
	"nixd",
	"zls",
	"ruff",
	"tflint",
	{
		"terraformls",
		exec = "terraform-ls",
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
	},
	{
		"ltex",
		exec = "ltex-ls",
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
	},
	"gopls",
}

-- Only install servers that exist + use custom options
for _, server in ipairs(servers) do
	local exec = ""
	local lsp = ""
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
	else
		lsp = server
		exec = server
	end

	local command = [[echo executable("]] .. exec .. [[")]]
	local out = vim.api.nvim_exec2(command, { output = true })
	local result = tonumber(out.output)
	if result ~= 0 then
		vim.lsp.enable(lsp)
		-- nvim_lsp[lsp].setup(setup)
	end
	::continue::
end

vim.g.rustaceanvim = {
	server = {
		on_attach = function(client, _)
			client.server_capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = false,
			}
		end,
		default_settings = {
			["rust-analyzer"] = {
				files = {
					watcherExclude = {
						"**/.direnv/**",
					},
					excludeDirs = {
						".direnv",
						".github",
					},
				},
				cargo = {
					features = "all",
				},
			},
		},
	},
}

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
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
