return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local opts = {
				github = { "actionlint" },
				python = {},
			}
			if vim.fn.executable("mypy") == 1 then
				table.insert(opts.python, "mypy")
				-- Override mypy to use the --check-untyped-def flag
				local mypy = require("lint").linters.mypy
				table.insert(mypy.args, "--check-untyped-def")
			end
			require("lint").linters_by_ft = opts
			-- 	python = { "mypy" },
			-- 	-- This is a custom yaml.github fileytpe that I created
			-- 	github = { "actionlint" },
			-- }
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()

					-- You can call `try_lint` with a linter name or a list of names to always
					-- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("cspell")
				end,
			})
		end,
	},
}
