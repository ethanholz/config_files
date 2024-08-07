local ls = require("luasnip")
-- Snippet creator
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local i = ls.insert_node
local f = ls.function_node

-- Get filename excluding extension
local filename = function()
	return f(function()
		local name = vim.fn.expand("%:r")
		return name
	end)
end

ls.config.set_config({
	updateevents = "TextChanged,TextChangedI",
	history = true,
	enable_autosnippets = true,
})
--
ls.add_snippets("markdown", {
	s("title", fmt([[# {}]], { filename() })),
})

ls.add_snippets("markdown", {
	s(
		"doc",
		fmt(
			[[
## **{}**
{}
#### Parameters
| parameter | type | required | description |
|-----------|------|----------|-------------|
```yaml
{}:
```
    ]],
			{ i(1), i(2), rep(1) }
		)
	),
})

ls.add_snippets("markdown", {
	s("lin", fmt([[| _{}_ | {} | {} | {} ]], { i(1), i(2), i(3), i(4) })),
})

ls.add_snippets("rust", {
	s(
		"aoc",
		fmt(
			[[let file = File::open("{}").expect("File not found");
let reader = io::BufReader::new(file).lines();
for line in reader {{
    {}
}}]],
			{ i(1), i(2) }
		)
	),
})
