return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"folke/which-key.nvim",
		},
		ft = "go",
		config = function()
			require("dapui").setup()
			require("dap-go").setup()
			local wk = require("which-key")
			wk.register({
				["<leader>"] = {
					d = {
						name = "Dap",
						u = { require("dapui").toggle, "Toggle Dap UI" },
						b = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
						B = {
							function()
								require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
							end,
							"Set Breakpoint with condition",
						},
						t = { require("dap").terminate, "Terminate Dap" },
					},
				},
				["<F2>"] = { require("dap").continue, "Dap Continue" },

				["<F7>"] = { require("dap").step_into, "Dap Step Into" },
				["<F8>"] = { require("dap").step_out, "Dap Step Out" },
				["<F9>"] = { require("dap").step_over, "Dap Step Over" },

				["<F1>"] = { require("dap-go").debug_test, "Dap Go Test" },
			})
		end,
	},
}
