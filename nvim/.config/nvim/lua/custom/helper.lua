local helper = {}


function helper.convert_case(text)
    local tmp = text:gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper)
    local standard = vim.split(tmp, " ", { trimempty = true })

    return string.lower(table.concat(standard, "_"))
end

function helper.is_wsl()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end

return helper
