local enable_autoformat = true
if not enable_autoformat then
	return
end

local exclude_list = { "ccls", "tsserver", "astro", "lua_ls", "salt_ls" }
local has_value = function(name)
	for _, value in ipairs(exclude_list) do
		if value == name then
			return true
		end
	end
	return false
end

-- Switch for controlling whether you want autoformatting.
--  Use :KickstartFormatToggle to toggle autoformatting on or off
local enabled = true
vim.api.nvim_create_user_command("KickstartFormatToggle", function()
	enabled = not enabled
	print("Setting autoformatting to: " .. tostring(enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
	if not _augroups[client.id] then
		local group_name = "kickstart-lsp-format-" .. client.name
		local id = vim.api.nvim_create_augroup(group_name, { clear = true })
		_augroups[client.id] = id
	end

	return _augroups[client.id]
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
	-- This is where we attach the autoformatting for reasonable clients
	callback = function(args)
		local client_id = args.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		local bufnr = args.buf
		if vim.bo.ft == "sls" then
			return
		end

		-- Only attach to clients that support document formatting
		if not client.server_capabilities.documentFormattingProvider or has_value(client.name) then
			return
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = get_augroup(client),
			buffer = bufnr,
			callback = function()
				if not enabled then
					return
				end
				-- if not vim.api.nvim_buf_get_option(bufnr, "modified") then
				-- 	return
				-- end

				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
})
