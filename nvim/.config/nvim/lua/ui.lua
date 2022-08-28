-- vim.cmd("colorscheme nightfox")
-- Only availble on latest nvim nightly at this time
vim.cmd.colorscheme("carbonfox")
-- vim.cmd.colorscheme("oxocarbon")

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "help", "terminal" },
	filetype_exclude = { "markdown" },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")

local function hook()
	local harpoon_number = require("harpoon.mark").get_index_of(vim.fn.bufname())
	if harpoon_number then
		return "ﯠ " .. harpoon_number
	else
		return "ﯡ "
	end
end
-- local function color()
-- 	if require("harpoon.mark").get_index_of(vim.fn.bufname()) then
-- 		return { fg = "#98be65", gui = "bold" }
-- 	else
-- 		return { fg = "#ec5f67" }
-- 	end
-- end
require("lualine").setup({
	sections = {
		lualine_y = {
			hook,
		},
	},
})
-- Used to enable nicer diagnostic lines
vim.diagnostic.config({
	virtual_text = false,
})
