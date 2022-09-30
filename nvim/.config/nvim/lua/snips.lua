local ls = require("luasnip")

-- Snippet creator
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node

-- This is a temporary function to handle conversion
local json_convert = function(index)
    return f(function(arg)
        if arg[1] == "" then
            return ""
        end
        local stringVal = arg[1][1]:lower()
        return { stringVal }
    end, { index })
end

ls.config.set_config({
    updateevents = "TextChanged,TextChangedI",
    history = true,
    enable_autosnippets = true,
})

ls.add_snippets("go", {
    s("jsc", fmt([[{} {} `json:"{}"`]], { i(1), i(2), json_convert(1) })),
})
