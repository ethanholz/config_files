local format_config = {}
local list = {}
local function formatter_not_installed(arg)
	local output = vim.fn.systemlist(arg)
	return not not string.find(output[1] or "", "command not found")
end

-- Functions to bootstrap formatters
function format_config.bootstrap()
	create_win()
	if formatter_not_installed("beautysh") then
		os.execute("pip install beautysh")
		redraw("beautysh is now installed")
	else
		redraw("beautysh already installed")
	end
	if formatter_not_installed("black") then
		os.execute("pip install black")
		redraw("black is now installed")
	else
		redraw("black already installed")
	end
	if formatter_not_installed("stylua") then
		os.execute("cargo install stylua")
		redraw("stylua is now installed")
	else
		redraw("stylua is already installed")
	end
end
function create_win()
	start_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command("botright vnew")
	win = vim.api.nvim_get_current_win()
	buf = vim.api.nvim_get_current_buf
	vim.api.nvim_buf_set_name(buf, "Test")
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "bootstrap")
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "cursorline", true)
end
function redraw(formatter)
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	table.insert(list, #list + 1, formatter)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, list)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
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
