return {
	settings = {
		gopls = {
			gofumpt = true,
			analyses = {
				unusedparams = true,
				shadow = true,
				structtag = false,
			},
			staticcheck = true,
			codelenses = { test = true },
			hints = {
				assignVariableTypes = true,
				composeLiteralFields = true,
				constantValues = true,
				functionTypeParameter = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
