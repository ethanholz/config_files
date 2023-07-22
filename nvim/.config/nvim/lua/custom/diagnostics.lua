local item = vim.api.nvim_create_user_command("SaltLintVersion", function()
	local handle = io.popen("salt-lint --version")
	local result = handle:read("*a")
	if handle ~= nil then
		handle:close()
	end
	print(result)
end, {})
