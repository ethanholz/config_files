local format_config = {}
local function formatter_not_installed(arg)
	local output = vim.fn.systemlist(arg)
	return not not string.find(output[1] or "", "command not found")
end
-- Function to bootstrap formatters
function format_config.bootstrap()
	if formatter_not_installed("beautysh") then
		os.execute("pip install beautysh")
	elseif formatter_not_installed("black") then
		os.execute("pip install black")
	elseif formatter_not_installed("stylua") then
		os.execute("cargo install stylua")
	end
	print("Bootstrap complete")
end
function format_config.setup()
	require("formatter").setup({
		logging = false,
		filetype = {
			lua = {
				function()
					return { exe = "stylua", args = {}, stdin = false }
				end,
			},
			python = {
				function()
					return { exe = "black", args = {}, stdin = false }
				end,
			},
			sh = {
				function()
					return { exe = "beautysh", args = {}, stdin = false }
				end,
			},
			zsh = {
				function()
					return { exe = "beautysh", args = {}, stdin = false }
				end,
			},
		},
	})
end

return format_config
