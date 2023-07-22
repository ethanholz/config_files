local ok, lualine = pcall(require, "lualine")
if ok then
	local ho, harpoon_mark = pcall(require, "harpoon.mark")
	local lualine_config = {}
	if ho then
		local function hook()
			local harpoon_number = harpoon_mark.get_index_of(vim.fn.bufname())
			if harpoon_number then
				return "ﯠ " .. harpoon_number
			else
				return "ﯡ "
			end
		end

		lualine_config["sections"] = {
			lualine_y = {
				hook,
			},
		}

		-- local lualine_config = {
		--     sections = {
		--         lualine_y = {
		--             hook,
		--         },
		--     },
		-- }
	end

	lualine.setup(lualine_config)

	vim.opt.cmdheight = 0
	vim.opt.laststatus = 3
end

local noice_config = {
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	require("notify").setup({
		background_colour = "#1e222a",
		render = "minimal",
		stages = "static",
		timeout = 5000,
	}),
}
require("noice").setup(noice_config)
