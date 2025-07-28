return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		branch = "0.1.x",
		init = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("harpoon")
		end,

		-- lazy = true,
		keys = {
			{ "<leader>ff", require("telescope.builtin").find_files, desc = "Find File" },
			{ "<leader>fg", require("telescope.builtin").live_grep, desc = "Live Grep" },
			{ "<leader>fb", require("telescope.builtin").buffers, desc = "Buffer List" },
			{ "<leader>fh", require("telescope.builtin").help_tags, desc = "Help Tags" },
			{ "<leader>fc", require("telescope.builtin").colorscheme, desc = "Colorschme" },
			{ "<leader>fq", require("telescope").extensions.harpoon.marks, desc = "Harpoon Marks" },
			{ "<leader>fs", require("telescope.builtin").grep_string, desc = "Grep String" },
			{ "<leader>s", require("telescope.builtin").spell_suggest, desc = "Spell suggest" },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		build = "make",
	},
}
