return {
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			local indent = require("mini.indentscope")
			indent.setup({
				draw = {
					animation = indent.gen_animation.none(),
				},
			})
		end,
	},
}
