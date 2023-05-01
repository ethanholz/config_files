local ls = require("luasnip")
require("neogen").setup({ snippet_engine = "luasnip" })
local helper = require("custom.helper")
-- Snippet creator
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node

-- This is a temporary function to handle conversion
local json_convert = function(index)
    return f(function(arg)
        if arg[1][1] == "" then
            return ""
        end
        local stringVal = helper.convert_case(arg[1][1])
        return { stringVal }
    end, { index })
end

-- Get filename excluding extension
local filename = function()
    return f(function()
        local name = vim.fn.expand("%:r")
        return name
    end)
end


--- Generates a filepath based name following basedir
---@param basedir string file after this point
---@return string path
---@return function filepath function
local filepath = function(basedir)
    return f(function()
        local path = vim.api.nvim_buf_get_name(0)
        local name = "/" .. vim.fs.basename(path)
        local normalized_base = vim.fs.normalize(basedir)
        local match = {}
        -- get everything following k3s and put into a string
        for element in string.gmatch(path, normalized_base .. "/(.*)$") do
            match[0] = element
        end
        -- remove the name from the
        local path2 = match[0]:gsub(name, "")
        -- replace '/' with '-'
        return path2:gsub("/", "-")
    end)
end

local k3s_filepath = function()
    return filepath("k3s")
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


ls.add_snippets("sls", {
    s(
        "k3s-ree",
        fmt(
            [[{}-reload:
  cmd.run:
    - name: k3s kubectl delete -f {{{{ filepath }}}} && k3s kubectl apply -f {{{{ filepath }}}}
    - onchanges:
      - file: {}-yaml]],
            { k3s_filepath(), k3s_filepath() }
        )
    ),
    s("fp", fmt([[{{% set filepath = '{}' %}}]], { i(1) })),
    s(
        "service-ree",
        fmt(
            [[{}-reenabled:
  cmd.run:
    - name: "systemctl reenable {}"
    - onchanges:
      - file: {}-service
    - require:
      - file: {}-service]],
            { filename(), filename(), filename(), filename() }
        )
    ),
    s(
        "rel",
        fmt(
            [[{}-reloading:
  cmd.run:
    - name: "systemctl restart {}"
    - onchanges:
      - file: {}-symlink
    - require:
      - service: {}-running]],
            { filename(), filename(), filename(), filename() }
        )
    ),
})

ls.add_snippets("go", {
    s("jsc", fmt([[{} {} `json:"{}"`]], { i(1), i(2), json_convert(1) })),
})

ls.add_snippets("c", {
    s("bis", fmt([[(Bi_Status_Fn({}) << {})]], { i(1), i(2) })),
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
